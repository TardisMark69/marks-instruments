#!/bin/bash
# make_thumbs.sh
# Generates compressed thumbnails for all site images.
# Thumbnails are ~1200px wide at 72% quality — fast to load.
# Originals are untouched and used by the lightbox for full-res zoom.
#
# Run this script from anywhere — it works on the fixed site folder below.

SITE_DIR="/home/markmandy/marks_legacy_files/11LinuxSWDev/Sales_Site"
THUMB_WIDTH=1200
QUALITY=72

IMAGES=(
  IMG_2049.JPG
  IMG_2050.JPG
  IMG_2051.JPG
  IMG_2052.JPG
  IMG_2053.JPG
  IMG_2054.JPG
  IMG_2055.JPG
  IMG_2056.JPG
  IMG_2057.JPG
  IMG_2058.JPG
  IMG_2059.JPG
  IMG_2060.JPG
  IMG_2061.JPG
  IMG_2062.JPG
  IMG_2063.JPG
  IMG_2064.JPG
  IMG_2065.JPG
  IMG_2066.JPG
  IMG_2067.JPG
  IMG_2068.JPG
  IMG_2069.JPG
  IMG_2070.JPG
  IMG_2079.JPG
  IMG_2080.JPG
  IMG_2081.JPG
  "Yamaha_45_ T116_Piano_Polished_Ebony.png"
)

echo "Generating thumbnails in: $SITE_DIR"
echo ""

for img in "${IMAGES[@]}"; do
  full_path="$SITE_DIR/$img"
  if [ ! -f "$full_path" ]; then
    echo "  SKIP (not found): $img"
    continue
  fi
  base="${img%.*}"
  ext="${img##*.}"
  thumb="${base}_thumb.${ext}"
  thumb_path="$SITE_DIR/$thumb"

  if [ -f "$thumb_path" ]; then
    echo "  EXISTS: $thumb"
  else
    convert "$full_path" -resize "${THUMB_WIDTH}x>" -quality "$QUALITY" "$thumb_path"
    orig_kb=$(du -k "$full_path" | cut -f1)
    thumb_kb=$(du -k "$thumb_path" | cut -f1)
    echo "  OK: $thumb  (${orig_kb}KB → ${thumb_kb}KB)"
  fi
done

echo ""
echo "All done. Thumbnails are in $SITE_DIR"
