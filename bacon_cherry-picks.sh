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

#
# insert cherry-picks below
#

# bacon  hdpi build
PATCH=15-03-06_bacon-xhdpi-build
FOLDER=device/oneplus/bacon
###
pushd ${FOLDER}
wget https://raw.githubusercontent.com/milaq/android/cm-12.0/patches/${PATCH}.patch
git am ${PATCH}.patch
check_clean

# minimize softbutton spacing
PATCH=15-03-02_minimize-softbutton-spacing
FOLDER=frameworks/base
###
pushd ${FOLDER}
wget https://raw.githubusercontent.com/milaq/android/cm-12.0/patches/${PATCH}.patch
git am ${PATCH}.patch
check_clean
