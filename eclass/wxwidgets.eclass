# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/wxwidgets.eclass,v 1.2 2004/08/07 03:40:19 pythonhead Exp $
#
# Author Rob Cakebread <pythonhead@gentoo.org>

# This eclass helps you find the correct wx-config script so ebuilds
# can use gtk, gtk2 or gtk2+unicode versions of wxGTK 

#FUNCTIONS:
# need-wxwidgets:
#   Arguments: gtk, gtk2 or unicode
#
# set-wxconfig
#   Arguments wxgtk, wxgtk2, or wxgtk2u

ECLASS=wxwidgets
INHERITED="$INHERITED $ECLASS"

need-wxwidgets() {

	debug-print-function $FUNCNAME $*

	case $1 in
		gtk)		set-wxconfig wxgtk;;
		gtk2)		set-wxconfig wxgtk2;;
		unicode)	set-wxconfig wxgtk2u;;
		*)		echo "!!! $FUNCNAME: Error: unrecognized wxconfig version $1 requested"
		exit 1;;
	esac

}


set-wxconfig() {

	debug-print-function $FUNCNAME $*

	local wxgtk_ver=`/usr/bin/wx-config --release`
	local wxconfig="/usr/bin/${1}-${wxgtk_ver}-config"
	local wxconfig_debug="/usr/bin/${1}d-${wxgtk_ver}-config"

	if [ -e ${wxconfig} ] ; then
		export WX_CONFIG=${wxconfig}
		echo " * Using ${wxconfig}"
	elif [ -e ${wxconfig_debug} ] ; then
		export WX_CONFIG=${wxconfig_debug}
		echo " * Using ${wxconfig_debug}"
	else
		echo "!!! $FUNCNAME: Error:  Can't find normal or debug version:"
		echo "!!! $FUNCNAME:         ${wxconfig} not found"
		echo "!!! $FUNCNAME:         ${wxconfig_debug} not found"
		case $1 in
			wxgtk)	 echo "!!! You need to emerge wxGTK with -no_wxgtk1 in your USE";;
			wxgtkd)	 echo "!!! You need to emerge wxGTK with -no_wxgtk1 in your USE";;
			wxgtk2)	 echo "!!! You need to emerge wxGTK with gtk2 in your USE";;
			wxgtk2d) echo "!!! You need to emerge wxGTK with gtk2 in your USE";;
			wxgtk2u) echo "!!! You need to emerge wxGTK with unicode in your USE";;
			wxgtk2ud) echo "!!! You need to emerge wxGTK with unicode in your USE";;
		esac
		exit 1
	fi
}


