#!/bin/sh
# GPKG -> PMTiles, same tippecanoe options as dep-coastlines scripts/continental.py
# usage: scripts/build_tiles.sh data/foo.gpkg data/coastlines.pmtiles
set -e
gpkg=$1; out=$2; tmp=$(mktemp -d)
roc="-y sig_time -y rate_time -y certainty"
parts=""
for l in shorelines_annual rates_of_change hotspots_zoom_1 hotspots_zoom_2 hotspots_zoom_3; do
  case $l in
    shorelines_annual) o="-y year -y certainty" ;;
    rates_of_change)   o="-B 10 $roc -y se_time" ;;
    hotspots_zoom_1)   o="-B 0 $roc" ;;
    hotspots_zoom_2)   o="-B 4 $roc" ;;
    hotspots_zoom_3)   o="-B 7 $roc" ;;
  esac
  ogr2ogr -f GeoJSONSeq -t_srs EPSG:4326 "$tmp/$l.geojsonl" "$gpkg" "$l"
  tippecanoe $o -pi -z13 -f -o "$tmp/$l.pmtiles" -L "$l:$tmp/$l.geojsonl"
  parts="$parts $tmp/$l.pmtiles"
done
tile-join -f -pk -o "$out" $parts
rm -rf "$tmp"
