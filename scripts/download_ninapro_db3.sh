#!/usr/bin/env bash
# Downloads NinaPro DB3 (11 transradial amputee subjects) preprocessed .mat files.
# Source: https://ninapro.hevs.ch/instructions/DB3.html
set -euo pipefail

RAW_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/data/ninapro_db3/raw"
BASE_URL="https://ninapro.hevs.ch/files/db3_Preproc"

mkdir -p "${RAW_DIR}"

for i in $(seq 1 11); do
  FILE="s${i}_0.zip"
  DEST="${RAW_DIR}/${FILE}"
  echo "Downloading subject ${i} (${FILE})..."
  curl -L -C - --retry 5 --retry-delay 5 -o "${DEST}" "${BASE_URL}/${FILE}"
  echo "Extracting ${FILE}..."
  unzip -q -o "${DEST}" -d "${RAW_DIR}"
done

echo "Done. All 11 subjects downloaded and extracted under ${RAW_DIR}"
