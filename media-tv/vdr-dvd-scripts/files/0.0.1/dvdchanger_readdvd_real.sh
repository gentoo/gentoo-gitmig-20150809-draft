#!/bin/sh
#
# dvdselect_readdvd.sh
#
# source: dvdselect-plugin
#
# an LinVDR angepasst, da LinVDR kein at-Kommando hat
# modified for LinVDR, because there is no at-command
# 
# This script will by called by the vdr-plugin dvdselect to copy a DVD to
# the local drive.
#
# It gets the following parameters:
#
# $1 = directory for dvd's (see plugin configuration menu)
# $2 = name of dvd
# $3 = original dvd-device

rm -f "$1/$2"
  
svdrpsend.pl -d localhost "MESG DVD einlesen gestartet"
dd if="$3" of="$1/$2"
svdrpsend.pl -d localhost "MESG DVD $2 fertig"

