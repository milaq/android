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

# hammerhead xhdpi build
apply hammerhead-xhdpi-build device/lge/hammerhead

# minimize softbutton spacing
apply minimize-softbutton-spacing frameworks/base

# dpi adjustment settings patch
apply dpi-preferably-allow-adjusting-to-higher-dpi packages/apps/Settings

