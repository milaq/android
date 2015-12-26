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
BRANCH=stable/cm-12.1-YOG4P

# Email: Add support for ignoring exchange server policy (1/2)
apply Add-support-for-ignoring-exchange-server-policy-1-2 packages/apps/Email

# Exchange: Add support for ignoring exchange server policy (2/2)
apply Add-support-for-ignoring-exchange-server-policy-2-2 packages/apps/Exchange

# recovery: non-touch hacks
apply 14-12-21_recovery-non-touch-hacks bootable/recovery

