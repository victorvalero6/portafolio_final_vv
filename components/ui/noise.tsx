"use client"

import { useRef, useEffect } from 'react';

const Noise = ({
  patternRefreshInterval = 4,
  patternAlpha = 15
}: {
  patternRefreshInterval?: number;
  patternAlpha?: number;
}) => {
  const grainRef = useRef<HTMLCanvasElement>(null);

  useEffect(() => {
    const canvas = grainRef.current;
    if (!canvas) return;

    // willReadFrequently: false — we only write, never read back
    const ctx = canvas.getContext('2d', { alpha: true, willReadFrequently: false });
    if (!ctx) return;

    // 256×256 instead of 1024×1024 → 16× fewer pixels per frame
    const SIZE = 256;
    canvas.width = SIZE;
    canvas.height = SIZE;

    // Pre-allocate once — avoid GC pressure each frame
    const imageData = ctx.createImageData(SIZE, SIZE);
    const data = imageData.data;

    // Pre-fill alpha channel once (never changes)
    for (let i = 3; i < data.length; i += 4) {
      data[i] = patternAlpha;
    }

    let frame = 0;
    let animationId: number;

    const drawGrain = () => {
      for (let i = 0; i < data.length; i += 4) {
        const v = (Math.random() * 255) | 0;
        data[i] = v;
        data[i + 1] = v;
        data[i + 2] = v;
      }
      ctx.putImageData(imageData, 0, 0);
    };

    const loop = () => {
      if (frame % patternRefreshInterval === 0) {
        drawGrain();
      }
      frame++;
      animationId = requestAnimationFrame(loop);
    };

    loop();

    return () => {
      cancelAnimationFrame(animationId);
    };
  }, [patternRefreshInterval, patternAlpha]);

  return (
    <canvas
      ref={grainRef}
      className="fixed left-0 top-0 w-screen h-screen pointer-events-none z-[50]"
      style={{ imageRendering: 'pixelated' }}
    />
  );
};

export default Noise;
