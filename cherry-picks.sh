#!/bin/bash

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

BRANCH=stable/cm-13.0-ZNH0E

# Email: Add support for ignoring exchange server policy (1/2)
#apply add-support-for-ignoring-exchange-server-policy-1-2 packages/apps/Email

# Exchange: Add support for ignoring exchange server policy (2/2)
#apply add-support-for-ignoring-exchange-server-policy-2-2 packages/apps/Exchange

# recovery: non-touch hacks
apply recovery-non-touch-hacks bootable/recovery

# modversion: add MLQ infix to indicate changes
apply modversion-add-MLQ-infix-to-indicate-changes vendor/cm

