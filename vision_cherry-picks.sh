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

# legacy camera support part 1
PATCH=14-08-19_legacy-camera-support-1
FOLDER=frameworks/av
###
pushd ${FOLDER}
wget https://raw.github.com/milaq/android/cm-11.0/patches/${PATCH}.patch
git am ${PATCH}.patch
check_clean

# legacy camera support part 2
PATCH=14-08-19_legacy-camera-support-2
FOLDER=frameworks/av
###
pushd ${FOLDER}
wget https://raw.github.com/milaq/android/cm-11.0/patches/${PATCH}.patch
git am ${PATCH}.patch
check_clean

# add INCALL_MUSIC stream type to getStrategy()
PATCH=14-08-19_add-INCALL_MUSIC-stream-type-to-getStrategy
FOLDER=hardware/qcom/audio/caf
###
pushd ${FOLDER}
wget https://raw.github.com/milaq/android/cm-11.0/patches/${PATCH}.patch
git am ${PATCH}.patch
check_clean

# fix legacy audio ringtone
PATCH=14-08-19_fix-legacy-hal-ringtone
FOLDER=hardware/qcom/audio/caf
###
pushd ${FOLDER}
wget https://raw.github.com/milaq/android/cm-11.0/patches/${PATCH}.patch
git am ${PATCH}.patch
check_clean