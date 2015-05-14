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

# wifi.c: allow devices to specify driver delay
PATCH=15-01-13_wifi.c-allow-devices-to-specify-driver-delay
FOLDER=hardware/libhardware_legacy
###
pushd ${FOLDER}
wget https://raw.github.com/milaq/android/cm-12.1/patches/${PATCH}.patch
git am ${PATCH}.patch
check_clean

# btservice/AdaperState: handle ENABLED_READY in OffState
PATCH=btservice-AdaperState-handle-ENABLED_READY-in-OffSta
FOLDER=packages/apps/Bluetooth
###
pushd ${FOLDER}
wget https://raw.github.com/milaq/android/cm-12.1/patches/${PATCH}.patch
git am ${PATCH}.patch
check_clean

# sepolicy: add a domain for lvm
FOLDER=external/sepolicy
###
pushd ${FOLDER}
git fetch http://review.cyanogenmod.org/CyanogenMod/android_external_sepolicy refs/changes/60/82660/2 && git cherry-pick FETCH_HEAD
check_clean

# art: allow devices to opt out of GAP check
FOLDER=art
###
pushd ${FOLDER}
git fetch http://review.cyanogenmod.org/CyanogenMod/android_art refs/changes/61/82661/1 && git cherry-pick FETCH_HEAD
check_clean

# libart: Allow adjustment of the base address
FOLDER=build
###
pushd ${FOLDER}
git fetch http://review.cyanogenmod.org/CyanogenMod/android_build refs/changes/68/82668/3 && git cherry-pick FETCH_HEAD
check_clean
