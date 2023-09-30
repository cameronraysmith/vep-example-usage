#!/usr/bin/env bash

set -euxo pipefail

CACHE_DIR="./cache"
VEP_MODE="online"  # Default to online | offline mode

if [ "${VEP_MODE}" == "offline" ]; then
    if [ ! -d "$CACHE_DIR/homo_sapiens" ]; then
        echo "VEP cache not found. Downloading..."
        mkdir -p $CACHE_DIR
        
        if command -v aria2c &> /dev/null; then
            aria2c -x 16 -s 16 -j 16 -k 1M -d $CACHE_DIR http://ftp.ensembl.org/pub/release-110/variation/indexed_vep_cache/homo_sapiens_vep_110_GRCh38.tar.gz
        else
            wget -P $CACHE_DIR http://ftp.ensembl.org/pub/release-110/variation/indexed_vep_cache/homo_sapiens_vep_110_GRCh38.tar.gz
        fi

        tar -xzf $CACHE_DIR/homo_sapiens_vep_110_GRCh38.tar.gz -C $CACHE_DIR
        rm $CACHE_DIR/homo_sapiens_vep_110_GRCh38.tar.gz
    else
        echo "VEP cache found. Proceeding to run VEP in offline mode."
    fi
else
    echo "Running VEP in online mode."
fi

VEP_MODE=$VEP_MODE docker-compose up
