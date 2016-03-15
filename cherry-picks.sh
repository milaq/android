#!/bin/bash
# ---------------------------------------------------------
# cherry-picks
# use pushd to enter directories
#
# add cherry-picks like this:
#
# # mkbootimg: support pagesize 8192
# pushd system/core
# git fetch https://github.com/CyanogenMod/android_system_core ics && git cherry-pick 67ffceadeab46d4a43aadac0f574b14e844e01a5
# check_clean
# ---------------------------------------------------------

function check_clean {
  if [ -e *.patch ]
  then
    rm *.patch
  fi
  if [ -e ".git/rebase-apply" ]
  then
    git am --abort
    popd
    exit 1
  elif [ -e ".git/CHERRY_PICK_HEAD" ]
  then
    git cherry-pick --abort
    popd
    exit 1
  fi
  popd
}

function apply {
  pushd $2
  wget https://raw.githubusercontent.com/milaq/android/$BRANCH/patches/$1.patch
  git am $1.patch
  check_clean
}

#
# insert cherry-picks below
#
BRANCH=gingerbread

# add lenovo a107 to targets
apply add-lenovo-a107-IdeaPad-A1 vendor/cyanogen

# add htc kovsky to targets
apply add-htc-kovsky vendor/cyanogen

# Add option to configure ramdisks built with mkimage for U-Boot (needed for a107)
apply custom-mkimage-ramdisks build

# SensorService: Don't always assume magnetometer is present (needed for a107)
apply no-magnetometer frameworks/base

# Added driver_cmd function to nl80211 driver (needed for kovsky)
apply nl80211_driver_cmd external/wpa_supplicant_6
