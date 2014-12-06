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

# Email: Add support for ignoring exchange server policy (1/2)
PATCH=14-12-06_Add-support-for-ignoring-exchange-server-policy-1-2
FOLDER=packages/apps/Email
###
pushd ${FOLDER}
wget https://raw.github.com/milaq/android/cm-12.0/patches/${PATCH}.patch
git am ${PATCH}.patch
check_clean

# Exchange: Add support for ignoring exchange server policy (2/2)
PATCH=14-12-06_Add-support-for-ignoring-exchange-server-policy-2-2
FOLDER=packages/apps/Exchange
###
pushd ${FOLDER}
wget https://raw.github.com/milaq/android/cm-12.0/patches/${PATCH}.patch
git am ${PATCH}.patch
check_clean