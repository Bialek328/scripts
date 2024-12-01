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

check_system() {
    sys_name=$(uname -s)
    if [[ $sys_name == MINGW64* ]]; then
        system="Windows"
    elif [[ $sys_name == Darwin* ]]; then
        system="MacOS"
    elif [[ $sys_name == Linux* ]]; then
        system="Linux"
    fi
}

activate_venv() {
    env_dir=$(find . -type d -maxdepth 1 -name "*env")
    abs_path=$(pwd)/$env_dir
    if [[ $system == "Windows" ]]; then
        source $env_dir/Scripts/activate
    else
        source $env_dir/bin/activate
    fi
}

install_requirements() {
    pip install -r requirements.txt
}

create_exe() {
    pip install pyinstaller
    main_dir=$(find . -type f -name "main.py")
    python3 -m PyInstaller --clean --onefile --window --noconfirm --console $main_dir
}


get_version
unpack_version
get_user_input
handle_flag
new_v="'$major_v.$minor_v.$build_v'"
echo ver=$new_v > version.py
echo "New version: " $new_v
check_system
echo "system:" $system
activate_venv
install_requirements
create_exe
echo "done"
