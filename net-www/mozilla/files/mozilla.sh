#!/bin/bash
#
# The contents of this file are subject to the Netscape Public
# License Version 1.1 (the "License"); you may not use this file
# except in compliance with the License. You may obtain a copy of
# the License at http://www.mozilla.org/NPL/
#
# Software distributed under the License is distributed on an "AS
# IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
# implied. See the License for the specific language governing
# rights and limitations under the License.
#
# The Original Code is mozilla.org code.
#
# The Initial Developer of the Original Code is Netscape
# Communications Corporation.  Portions created by Netscape are
# Copyright (C) 1998 Netscape Communications Corporation. All
# Rights Reserved.
#
# Contributor(s): 
#

## 
## Usage:
##
## $ mozilla
##
## This script is meant to run a mozilla program from the mozilla
## rpm installation.
##
## The script will setup all the environment voodoo needed to make
## mozilla work.

## Faster startup
#export XPCOM_CHECK_THREADSAFE=0

cmdname=`basename $0`

## don't leave any core files around
ulimit -c 0

##
## Variables
##
MOZ_DIST_BIN="/usr/lib/mozilla"
MOZ_PROGRAM="/usr/lib/mozilla/mozilla-bin"
MOZ_CLIENT_PROGRAM="/usr/lib/mozilla/mozilla-xremote-client"

##
## Set MOZILLA_FIVE_HOME
##
MOZILLA_FIVE_HOME="/usr/lib/mozilla"

export MOZILLA_FIVE_HOME

##
## Set LD_PRELOAD for old plugins
##
if [ -f /usr/lib/mozilla/libc++mem.so ]
then
  if [ "$LD_PRELOAD" ]
  then
    LD_PRELOAD="/usr/lib/mozilla/libc++mem.so $LD_PRELOAD"
  else
    LD_PRELOAD=/usr/lib/mozilla/libc++mem.so
  fi
  export LD_PRELOAD
fi

##
## Set LD_LIBRARY_PATH
##
if [ "$LD_LIBRARY_PATH" ]
then
  LD_LIBRARY_PATH="/usr/lib/mozilla:/usr/lib/mozilla/plugins:$LD_LIBRARY_PATH"
else
  LD_LIBRARY_PATH="/usr/lib/mozilla:/usr/lib/mozilla/plugins"
fi

export LD_LIBRARY_PATH

##
## Make sure that we set the plugin path for backwards compatibility
## Set MOZ_PLUGIN_PATH to $HOME/.mozilla/plugins if not set
##
export MOZ_PLUGIN_PATH=/usr/lib/mozilla/plugins

if [ "$HOME" ]; then
  export MOZ_PLUGIN_PATH="$MOZ_PLUGIN_PATH:$HOME/.mozilla/plugins"
fi

##
## Set FONTCONFIG_PATH for Xft/fontconfig
##
FONTCONFIG_PATH="/etc/fonts:${MOZILLA_FIVE_HOME}/res/Xft"
export FONTCONFIG_PATH

## 
## Autodetect language 
##
grep -q $HOME/.mozilla $HOME/.mozilla/appreg > /dev/null 2>/dev/null
SET_LANG=$?
if [ "$HOME" -a "$LANG" -a "$SET_LANG" != "0" ]; then
    MOZ_LANG=`grep -E "^$LANG[[:space:]]" $MOZILLA_FIVE_HOME/chrome/locale.alias | tr -s [:blank:] | cut -f 2`
    for i in "$@";do 
	[ "$i" = "-UILocale" ] && MOZ_LANG=""
    done
    if [ "$MOZ_LANG" -a -r "$MOZILLA_FIVE_HOME/chrome/$MOZ_LANG.jar" ]; then
       MOZ_LANG="-UILocale $MOZ_LANG"
    else
       unset MOZ_LANG
    fi
fi

# Figure out if we need to ser LD_ASSUME_KERNEL for older versions of the JVM.

function set_jvm_vars() {

    # see if the jvm exists in either of the locations
    if [ -L /usr/lib/mozilla/plugins/javaplugin_oji.so ]; then
        JVM_ORIG_LINK=/usr/lib/mozilla/plugins/javaplugin_oji.so
    fi

    if [ -L /usr/lib/mozilla/plugins/libjavaplugin_oji.so ]; then
        JVM_ORIG_LINK=/usr/lib/mozilla/plugins/libjavaplugin_oji.so
    fi

    if [ -z "$JVM_ORIG_LINK" ]; then
        return;
    fi

    JVM_LINK=`perl -e "print readlink('$JVM_ORIG_LINK')"`

    # is it relative?  if so append the full path

    echo "${JVM_LINK}" | grep -e "^/" 2>&1 > /dev/null

    if [ "$?" -ne "0" ]; then
	JVM_LINK=/usr/lib/mozilla/plugins/${JVM_LINK}
    fi

    JVM_BASE=`basename $JVM_LINK`
    JVM_DIR=`echo $JVM_LINK | sed -e s/$JVM_BASE//g`
    JVM_COMMAND=$JVM_DIR/java
    if [ ! -r $JVM_COMMAND ]; then
       JVM_DIR=${JVM_DIR}../../../bin/
       JVM_COMMAND=$JVM_DIR/java
       # does the command exist?
       if [ ! -r "$JVM_COMMAND" ]; then
           return
       fi
    fi

    # export this temporarily - it seems to work with old and new
    # versions of the JVM.
    export LD_ASSUME_KERNEL=2.2.5

    # get the version
    JVM_VERSION=`$JVM_COMMAND -version 2>&1`

    unset LD_ASSUME_KERNEL

    JVM_VERSION=`echo $JVM_VERSION | grep version | cut -f 3 -d " " | sed -e 's/\"//g'`

    case "$JVM_VERSION" in
	(1.3.0*)
	# bad JVM
	export LD_ASSUME_KERNEL=2.2.5
	;;
    esac
}

function check_running() {
	if [ -x $MOZ_CLIENT_PROGRAM ]; then
      $MOZ_CLIENT_PROGRAM 'ping()' 2>/dev/null >/dev/null
      RETURN_VAL=$?
      if [ "$RETURN_VAL" -eq "2" ]; then
        echo 0
        return 0
      else
        echo 1
        return 1
      fi
	else
	  echo 0
	  return 0
	fi
}

function open_mail() {
    if [ "${ALREADY_RUNNING}" -eq "1" ]; then
      exec $MOZ_CLIENT_PROGRAM 'xfeDoCommand(openInbox)' \
        2>/dev/null >/dev/null
    else
      exec $MOZ_PROGRAM $MOZ_LANG $*
    fi
}

function open_compose() {
    if [ "${ALREADY_RUNNING}" -eq "1" ]; then
      exec $MOZ_CLIENT_PROGRAM 'xfeDoCommand(composeMessage)' \
        2>/dev/null >/dev/null
    else
      exec $MOZ_PROGRAM $MOZ_LANG $*
    fi
}

# OK, here's where all the real work gets done

# set our JVM vars
set_jvm_vars

# check to see if there's an already running instance or not
ALREADY_RUNNING=`check_running`

# If there is no command line argument at all then try to open a new
# window in an already running instance.
if [ "${ALREADY_RUNNING}" -eq "1" ] && [ -z "$1" ]; then
  exec $MOZ_CLIENT_PROGRAM "xfeDoCommand(openBrowser)" 2>/dev/null >/dev/null
fi

# if there's no command line argument and there's not a running
# instance then just fire up a new copy of the browser
if [ -z "$1" ]; then
  exec $MOZ_PROGRAM $MOZ_LANG 2>/dev/null >/dev/null
fi

unset RETURN_VAL

# If there's a command line argument but it doesn't begin with a -
# it's probably a url.  Try to send it to a running instance.
USE_EXIST=0
NEW_WINDOW=
opt="$1"
case "$opt" in
  -mail)
      open_mail ${1+"$@"}
      ;;
  -compose)
      open_compose ${1+"$@"}
      ;;
  -*) ;;
  *) USE_EXIST=1 ;;
esac

  othersopt=
 optlast=
 for i in "$@";do optlast=$i;done #last arg
 for i in "$@";do  [[ $i == $optlast ]] && break; othersopt="$othersopt $i";done #others arg
 #???: needs check if othersopt begin with -* ?
 
 if [[ $optlast != *:/* && -e $optlast ]];then
     [[ $optlast != /* ]] && optlast=file://$PWD/$optlast
 elif [[ $optlast == *:/* || -n $othersopt ]];then #???? like before...
     NEW_WINDOW=1
 fi

if [ "${USE_EXIST}" -eq "1" ] && [ "${ALREADY_RUNNING}" -eq "1" ]; then
     if [[ -z $NEW_WINDOW ]];then
 	exec $MOZ_CLIENT_PROGRAM $othersopt  "openurl($optlast)" 2>/dev/null >/dev/null
     else
 	exec $MOZ_CLIENT_PROGRAM $othersopt  "openurl($optlast,new-window)" 2>/dev/null >/dev/null
     fi
fi

exec $MOZ_PROGRAM $MOZ_LANG $othersopt "$optlast"
