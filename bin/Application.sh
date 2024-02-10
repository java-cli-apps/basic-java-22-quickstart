#!/usr/bin/bash

get_absolute_path() {
    case "$1" in
        /*) path="$1";;
        *)  path="$(pwd)/$1";;
    esac
    realpath "$path"
}

shell_script_name=$(basename "$0")
bin_dir=$(get_absolute_path "$(dirname "$0")")

app_dir=$(dirname "${bin_dir}")
java_file_name=${shell_script_name/sh/java}

APP_DIR=${app_dir} "${app_dir}/src/${java_file_name}" "$@"
