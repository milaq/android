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

# DisplayDevice: Backwards compatibility with old EGL
PATCH=14-03-25_backwards-compatibility-with-old-egl
FOLDER=frameworks/native
###
pushd ${FOLDER}
wget https://raw.github.com/milaq/android/cm-11.0/patches/${PATCH}.patch
git am ${PATCH}.patch
check_clean

# dialer: allow sensor rotation in contacts
PATCH=14-10-07_dialer-allow-sensor-rotation-in-contacts
FOLDER=packages/apps/Dialer
###
pushd ${FOLDER}
wget https://raw.github.com/milaq/android/cm-11.0/patches/${PATCH}.patch
git am ${PATCH}.patch
check_clean

# Email: Add support for ignoring exchange server policy (1/2)
PATCH=14-11-12_Add-support-for-ignoring-exchange-server-policy-1-2
FOLDER=packages/apps/Email
###
pushd ${FOLDER}
wget https://raw.github.com/milaq/android/cm-11.0/patches/${PATCH}.patch
git am ${PATCH}.patch
check_clean

# Exchange: Add support for ignoring exchange server policy (2/2)
PATCH=14-11-12_Add-support-for-ignoring-exchange-server-policy-2-2
FOLDER=packages/apps/Exchange
###
pushd ${FOLDER}
wget https://raw.github.com/milaq/android/cm-11.0/patches/${PATCH}.patch
git am ${PATCH}.patch
check_clean
