#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 3 ]]; then
  cat >&2 <<'USAGE'
Usage:
  hyperframes_docker_render.sh PROJECT_DIR VIDEO_OUTPUT_MP4 [AUDIO_INPUT] FINAL_OUTPUT_MP4

Examples:
  hyperframes_docker_render.sh /tmp/ebru-hyperframes-test \
    /tmp/ebru-hyperframes-test/renders/demo-docker-30fps.mp4 \
    /tmp/ebru-hyperframes-test/assets/ebru-demo-pop-bed.wav \
    "/Users/cenktk/Desktop/Hermes_Agent /Videolar/HyperFrames/demo-docker-30fps-muzikli.mp4"

  hyperframes_docker_render.sh /tmp/ebru-hyperframes-test renders/demo-docker-30fps.mp4 final.mp4
USAGE
  exit 64
fi

PROJECT_DIR="$1"
VIDEO_OUT="$2"
shift 2

AUDIO_IN=""
FINAL_OUT=""
if [[ $# -eq 1 ]]; then
  FINAL_OUT="$1"
elif [[ $# -eq 2 ]]; then
  AUDIO_IN="$1"
  FINAL_OUT="$2"
else
  echo "Invalid arguments" >&2
  exit 64
fi

open -gj -a Docker >/dev/null 2>&1 || open -a Docker >/dev/null 2>&1 || true
export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"
mkdir -p /tmp/docker-no-creds
printf '{"auths":{}}\n' > /tmp/docker-no-creds/config.json
export DOCKER_CONFIG=/tmp/docker-no-creds

for i in {1..60}; do
  if docker info >/dev/null 2>&1; then
    break
  fi
  sleep 2
  if [[ "$i" -eq 60 ]]; then
    echo "Docker Desktop is not ready" >&2
    exit 1
  fi
done

mkdir -p "$(dirname "$VIDEO_OUT")" "$(dirname "$FINAL_OUT")"
cd "$PROJECT_DIR"

npx --yes hyperframes@0.6.84 render --docker --fps 30 --quality draft --workers 4 --output "$VIDEO_OUT"

if [[ -n "$AUDIO_IN" ]]; then
  ffmpeg -y -i "$VIDEO_OUT" -i "$AUDIO_IN" -c:v copy -c:a aac -b:a 192k -shortest "$FINAL_OUT"
else
  cp "$VIDEO_OUT" "$FINAL_OUT"
fi

ffprobe -v error -select_streams v:0 \
  -show_entries stream=codec_name,width,height,r_frame_rate,avg_frame_rate,nb_frames,duration \
  -of default=noprint_wrappers=1 "$FINAL_OUT"

if ffprobe -v error -select_streams a:0 -show_entries stream=codec_name -of csv=p=0 "$FINAL_OUT" | grep -q .; then
  ffprobe -v error -select_streams a:0 \
    -show_entries stream=codec_name,sample_rate,channels,duration \
    -of default=noprint_wrappers=1 "$FINAL_OUT"
fi

echo "DONE: $FINAL_OUT"
