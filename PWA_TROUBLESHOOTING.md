# iOS PWA Debugging Guide

If the immersive mode is not working (e.g., status bar is not transparent or address bar is still visible), please follow these steps:

## 1. Correct Testing Method
**PWA features DO NOT work in the Safari browser view.** You must:
1. Open the site in Safari on iOS.
2. Tap "Share" -> "Add to Home Screen".
3. **Open the app from the Home Screen icon.**

## 2. Clearing Cache (Critical)
iOS caches the manifest file aggressively. If you added it to the home screen *before* we made the changes:
1. **Delete** the existing icon from your home screen.
2. **Clear Safari Source Data** (Settings -> Safari -> Advanced -> Website Data -> Remove All Website Data - or just for localhost).
3. **Restart the Next.js server** (`Ctrl+C` and `npm run dev`) to ensure no server-side caching.
4. Add to Home Screen again.

## 3. Verify Server Output
We confirmed that your server is correctly sending the meta tags:
- `<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">`
- `<meta name="viewport" content="... viewport-fit=cover">`

## 4. Troubleshooting Visuals
If you see the content behind the status bar but it's hard to read:
- The `safe-area-inset` padding in `globals.css` pushes your *text* down so it's readable.
- The *background* color of the body extends to the top.
- If you check just the background color in the status bar, that is working as intended ("background covers everything").

## 5. Localhost Issues
Sometimes iOS requires HTTPS for full PWA capabilities, but `localhost` is usually exempt. If testing on a real device via network IP (e.g., `192.168.1.x:3000`), you **might need a local explicit HTTPS proxy** or tunneling (like ngrok) because iOS often ignores PWA directives on insecure HTTP connections except specifically `localhost`.

**Recommended:** Use `ngrok http 3000` to get an HTTPS URL for testing on your phone.
