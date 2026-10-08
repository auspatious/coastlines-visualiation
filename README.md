# Coastlines visualisation

Simple MapLibre map of a DEP Coastlines GeoPackage.

    scripts/build_tiles.sh data/<file>.gpkg data/coastlines.pmtiles   # needs tippecanoe, gdal
    npx serve public                                                       # PMTiles needs HTTP range requests

Styles are copied from [dep-tileserver](https://github.com/digitalearthpacific/dep-tileserver) (`styles.json`).
Basemaps use the MapTiler key from cogniscient (origin-restricted; falls back to OSM elsewhere).
