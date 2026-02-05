# iOS Safe Areas - Quick Reference Card

## 🎯 When to Use Safe Areas

| Element Type | Use Safe Padding? | Example |
|-------------|-------------------|---------|
| Background/Overlay | ❌ No | `LiquidMetalBackground`, gradient divs |
| Section Content | ✅ Yes | Hero, Work, About sections |
| Fixed Navbar | ✅ Yes | Top navigation |
| Fixed Footer/Buttons | ✅ Yes | Bottom CTAs, page indicators |
| Scrollable Content | ✅ Yes | Any section with `overflow-y-auto` |
| Modal/Dialog | ✅ Yes | Full-screen modals |
| Toast/Notifications | ✅ Yes | Fixed position alerts |

---

## 📋 CSS Utility Classes

### Basic Classes
```css
.safe-top       /* Top only */
.safe-right     /* Right only */
.safe-bottom    /* Bottom only */
.safe-left      /* Left only */
.safe-x         /* Left + Right */
.safe-y         /* Top + Bottom */
.safe-all       /* All four sides */
```

### Combined Classes (Safe Area + Design Spacing)
```css
.safe-px-4      /* Horizontal: safe area + 1rem */
.safe-py-20     /* Vertical: safe area + 5rem */
.safe-pt-24     /* Top: safe area + 6rem */
.safe-pb-20     /* Bottom: safe area + 5rem */
```

---

## 🔨 Common Patterns

### Pattern 1: Standard Section
```tsx
<section className="min-w-full snap-start safe-px-4 safe-pt-24 safe-pb-20">
  <div className="mx-auto max-w-4xl">
    {/* Content */}
  </div>
</section>
```

### Pattern 2: Fixed Top Element
```tsx
<nav 
  className="fixed top-0 left-0 right-0 z-50"
  style={{
    paddingTop: 'calc(var(--safe-area-inset-top) + 1rem)',
    paddingLeft: 'calc(var(--safe-area-inset-left) + 1rem)',
    paddingRight: 'calc(var(--safe-area-inset-right) + 1rem)',
  }}
>
  {/* Navbar content */}
</nav>
```

### Pattern 3: Fixed Bottom Element
```tsx
<div 
  className="fixed bottom-0 left-0 right-0"
  style={{
    paddingBottom: 'calc(var(--safe-area-inset-bottom) + 2rem)',
  }}
>
  {/* Button or indicator */}
</div>
```

### Pattern 4: Centered Floating Element
```tsx
<button
  className="fixed left-1/2 -translate-x-1/2"
  style={{
    bottom: 'calc(var(--safe-area-inset-bottom) + 2rem)',
  }}
>
  Submit
</button>
```

---

## 🎨 CSS Variables Reference

```css
/* Available globally */
--safe-area-inset-top
--safe-area-inset-right
--safe-area-inset-bottom
--safe-area-inset-left

/* Usage in calc() */
padding-top: calc(var(--safe-area-inset-top) + 2rem);
```

---

## ⚠️ Common Mistakes

### ❌ DON'T
```tsx
/* Don't add safe padding to backgrounds */
<div className="fixed inset-0 bg-gradient safe-all">

/* Don't use Tailwind utilities for complex calc() */
<div className="pt-[calc(var(--safe-area-inset-top)+2rem)]">
```

### ✅ DO
```tsx
/* Backgrounds span full screen */
<div className="fixed inset-0 bg-gradient">

/* Use inline styles for complex calc() */
<div style={{ paddingTop: 'calc(var(--safe-area-inset-top) + 2rem)' }}>
```

---

## 📱 Test Devices Checklist

- [ ] iPhone 15 Pro (Dynamic Island)
- [ ] iPhone 14 (standard notch)
- [ ] iPhone SE (no notch)
- [ ] iPad (minimal safe areas)
- [ ] Portrait orientation
- [ ] Landscape orientation

---

## 🚨 Debug Tips

### Check Safe Area Values
```javascript
// In browser console on iOS
console.log({
  top: getComputedStyle(document.documentElement).getPropertyValue('--safe-area-inset-top'),
  right: getComputedStyle(document.documentElement).getPropertyValue('--safe-area-inset-right'),
  bottom: getComputedStyle(document.documentElement).getPropertyValue('--safe-area-inset-bottom'),
  left: getComputedStyle(document.documentElement).getPropertyValue('--safe-area-inset-left'),
});
```

### Visual Debug Layer
```css
/* Add to globals.css temporarily */
.safe-debug::after {
  content: '';
  position: fixed;
  inset: 0;
  pointer-events: none;
  border: 4px solid red;
  border-top-width: calc(var(--safe-area-inset-top) + 4px);
  border-bottom-width: calc(var(--safe-area-inset-bottom) + 4px);
  border-left-width: calc(var(--safe-area-inset-left) + 4px);
  border-right-width: calc(var(--safe-area-inset-right) + 4px);
  z-index: 9999;
}
```

---

## 📦 Implementation Checklist

- [x] Viewport meta configured (`viewportFit: 'cover'`)
- [x] CSS variables defined in `:root`
- [x] Utility classes created
- [x] All sections updated
- [x] Fixed elements updated
- [x] Tested on iOS device

---

## 🔗 Quick Links

- Full Guide: `/IOS_SAFE_AREAS_GUIDE.md`
- CSS: `/app/globals.css`
- Layout: `/app/layout.tsx`
- Main Page: `/app/page.tsx`

---

**Last Updated:** 2026-02-04  
**Version:** 1.0.0
