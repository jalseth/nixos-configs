#!/usr/bin/env bash

set -euo pipefail

config_path=""
channel_version=""
format=""
nixos_build_args=()

while [[ $# -gt 0 ]]; do
  case "${1}" in
    -c | --config_path)
      config_path="${2}"
      shift
      ;;
    -f | --format)
      format="${2}"
      shift
      ;;
    -v | --channel_version)
      channel_version="${2}"
      shift
      ;;
    -d | --disk_size)
      nixos_build_args+=("--disk-size" "${2}")
      shift
      ;;
    *)
      abort "unknown option ${1}"
      ;;
  esac
  shift
done

out_path=$(nix run github:jalseth/nixos-generators -- \
  "${nixos_build_args[@]}" \
  -I "nixpkgs=channel:${channel_version}" \
  -f "${format}" \
  -c "${config_path}")

cp "${out_path}" .
file_name=$(echo -n "${out_path}" | rev | cut -d"/" -f1 | rev)
chmod 0660 "${file_name}"
