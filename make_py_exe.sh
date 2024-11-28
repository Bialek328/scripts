# !/usr/bin/env bash

get_version() {
    version=$(ggrep -oP "(?<=ver=')[^']+" version.py) 
    echo "Current Sw version:" $version

}

unpack_version() {
    major_v=${version:0:1}
    minor_v=${version:2:1}
    build_v=${version:4:1}
}

get_user_input() {
    echo "M - increase major version, set minot and build to 0"
    echo "m - increase minor version, set build to 0"
    echo "b - increase build verrsion"
    echo "k - keep current version"
    read -p "Choose one flag:" flag
}

handle_flag() {
    case $flag in 
        M) ((major_v++)) && minor_v=0 && build_v=0;;
        m) ((minor_v++)) && build_v=0;;
        b) ((build_v++));;
        k) echo "no changes to version";;
        *) echo "Wrong flag!";;
    esac

}

get_version
unpack_version
get_user_input
handle_flag
new_v="'$major_v.$minor_v.$build_v'"
echo ver=$new_v > version.py
echo "New version: " $new_v
