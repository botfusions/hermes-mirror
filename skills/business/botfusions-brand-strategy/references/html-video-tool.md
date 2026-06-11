# html-video (nexu-io) — HTML-to-Video Meta-Layer

## What It Is
Open-source meta-layer over multiple render engines. Turns HTML/CSS/GSAP → real MP4 via headless Chromium + ffmpeg. Apache-2.0, local only, no per-render fees.

## Repo
- GitHub: https://github.com/nexu-io/html-video
- Local clone: `/Users/cenktk/Desktop/Hermes_Agent /Projeler/html-video`

## Render Engines
| Engine | Status |
|--------|--------|
| Hyperframes | ✅ Active — the only working engine |
| Remotion | 🗺️ Planned, adapter exists but not wired |
| Motion Canvas / Revideo | 🗺️ Planned |

## 21 Templates
Data viz (NYT chart, Swiss grid, Vignelli), Titles (glitch, kinetic type), Heroes (liquid gradient, light leak), Product promos, Explainers (decision tree), Outro.

## Botfusions GEO Project
- Location: `projects/botfusions-geo-demo/`
- 30s 4-scene video: Hero → Problem → Solution → CTA
- Rendered with: `npx hyperframes@0.6.84 render --fps 30 --quality draft --workers 2`

## Typical Workflow
1. Write HTML composition with GSAP animations
2. `npx hyperframes render --fps 30 --output out.mp4`
3. `ffmpeg -i out.mp4 -i music.wav -c:v copy -c:a aac -shortest final.mp4`
4. `ffprobe` to verify FPS/duration/frames
5. Publish via OmniSocials

## Key Rules
- Root element needs `data-composition-id="main" data-start="0" data-duration="30" data-width="1280" data-height="720"`
- GSAP timeline: `window.__timelines["main"] = tl`
- Run `npm run check` before rendering
- Hermes ACP CLI supported as agent backend
- AI soundtrack via MiniMax API (optional)
