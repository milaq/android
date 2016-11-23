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

BRANCH=cm-14.1

# Email: ignore exchange server policy (1/2)
apply ignore-exchange-server-policy-1-2 packages/apps/Email

# Exchange: ignore exchange server policy (2/2)
apply ignore-exchange-server-policy-2-2 packages/apps/Exchange

# modversion: add MLQ infix to indicate changes
apply modversion-add-MLQ-infix-to-indicate-changes vendor/cm
