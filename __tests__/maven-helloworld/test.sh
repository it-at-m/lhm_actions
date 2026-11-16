#!/bin/bash

releaseVersion(){
  IFS="." read -r major minor patch <<< ${MVN_VERSION/-SNAPSHOT/}
  case $RELEASE_METHOD in
  major)
    let major++
    # if someone manually changed the version in pom to "<major>.<minor>.0-SNAPSHOT"
    if [ patch != "0" ]
     then let patch--; fi
    ;;
  minor)
    let minor++
    # if someone manually changed the version in pom to "<major>.<minor>.0-SNAPSHOT"
    let "patch=(patch != "0") ? --patch : patch"
    ;;
  patch)
    ;;
  * )
    echo "unknown RELEASE_METHOD: $RELEASE_METHOD"
  esac
  RELEASE=$major.$minor.$patch
}

nextVersion(){

}

export RELEASE_VERSION=2.0.0;
export RELEASE_METHOD=minor
export MVN_VERSION=1.2.3-SNAPSHOT

RELEASE=${MVN_VERSION/-SNAPSHOT/}
echo $RELEASE
releaseVersion
echo $RELEASE

