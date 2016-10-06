#!/bin/bash

function check_clean {
  if [ -e *.patch ]
  then
    rm *.patch
  fi
  if [ -e ".git/rebase-apply" ]
  then
    git am --abort
    popd > /dev/null
    exit 1
  elif [ -e ".git/CHERRY_PICK_HEAD" ]
  then
    git cherry-pick --abort
    popd > /dev/null
    exit 1
  fi
  popd > /dev/null
}

function apply {
  pushd $2 > /dev/null
  echo "Getting: $1"
  wget -q https://raw.githubusercontent.com/milaq/android/$BRANCH/patches/$1.patch
  git am $1.patch
  echo ""
  check_clean
}

BRANCH=cm-13.0

# mako hdpi build
apply mako-hdpi-build device/lge/mako

# minimize softbutton spacing
apply minimize-softbutton-spacing frameworks/base

# dpi adjustment settings patch
apply dpi-preferably-allow-adjusting-to-higher-dpi packages/apps/Settings

