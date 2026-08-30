#!/usr/bin/env bash
# Downloads the EMG-EPN-612 dataset (612 subjects, Myo armband) from Zenodo.
# Source: https://zenodo.org/records/4421500 (CC-BY 4.0)
set -euo pipefail

RAW_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/data/epn612/raw"
URL="https://zenodo.org/api/records/4421500/files/EMG-EPN612%20Dataset.zip/content"
ZIP_PATH="${RAW_DIR}/EMG-EPN612_Dataset.zip"
EXPECTED_MD5="98bd3c315efab607cc54b2ed2f8f3ada"

mkdir -p "${RAW_DIR}"

echo "Downloading EMG-EPN-612 dataset (~5.5 GB) to ${ZIP_PATH}"
curl -L -C - --retry 5 --retry-delay 5 -o "${ZIP_PATH}" "${URL}"

echo "Verifying MD5 checksum..."
ACTUAL_MD5=$(md5sum "${ZIP_PATH}" | awk '{print $1}')
if [[ "${ACTUAL_MD5}" != "${EXPECTED_MD5}" ]]; then
  echo "MD5 mismatch: expected ${EXPECTED_MD5}, got ${ACTUAL_MD5}" >&2
  exit 1
fi
echo "Checksum OK."

echo "Extracting..."
unzip -q -o "${ZIP_PATH}" -d "${RAW_DIR}"

echo "Done. Dataset extracted under ${RAW_DIR}"
