# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/wxwidgets.eclass,v 1.4 2004/11/13 02:50:53 pythonhead Exp $
#
# Author Rob Cakebread <pythonhead@gentoo.org>

# This eclass helps you find the correct wx-config script so ebuilds
# can use gtk, gtk2 or gtk2+unicode versions of wxGTK 

# FUNCTIONS:
# need-wxwidgets:
#   Arguments: gtk, gtk2 or unicode
#
#
# set-wxconfig
#   Arguments: (wxGTK 2.4) wxgtk, wxgtk2, or wxgtk2u
#   Arguments: (wxGTK 2.5 and 2.6) gtk, gtk2, or unicode
#   Note: Don't call this function directly from ebuilds

ECLASS=wxwidgets
INHERITED="$INHERITED $ECLASS"

need-wxwidgets() {
	debug-print-function $FUNCNAME $*
	#If you want to use wxGTK-2.5* export WX_GTK_VER in your ebuild:
	if [ "${WX_GTK_VER}" = "2.5" ]; then
		case $1 in
			gtk)		set-wxconfig gtk-ansi;;
			gtk2)		set-wxconfig gtk2-ansi;;
			unicode)	set-wxconfig gtk2-unicode;;
			*)		echo "!!! $FUNCNAME: Error: unrecognized wxconfig version $1 requested"
			exit 1;;
		esac

	else
		WX_GTK_VER="2.4"
		case $1 in
			gtk)		set-wxconfig wxgtk;;
			gtk2)		set-wxconfig wxgtk2;;
			unicode)	set-wxconfig wxgtk2u;;
			*)		echo "!!! $FUNCNAME: Error: unrecognized wxconfig version $1 requested"
			exit 1;;
		esac
	fi
}


set-wxconfig() {

	debug-print-function $FUNCNAME $*

	if [ "${WX_GTK_VER}" = "2.5" ] ; then
		wxconfig_prefix="/usr/lib/wx/config"
		wxconfig_name="${1}-release-${WX_GTK_VER}"
		wxconfig="${wxconfig_prefix}/${wxconfig_name}"
		wxconfig_debug_name="${1}d-release-${WX_GTK_VER}"
		wxconfig_debug="${wxconfig_prefix}/${wxconfig_debug_name}"
	else
		# Default is 2.4:
		wxconfig_prefix="/usr/bin"
		wxconfig_name="${1}-${WX_GTK_VER}-config"
		wxconfig="${wxconfig_prefix}/${wxconfig_name}"
		wxconfig_debug_name="${1}d-${WX_GTK_VER}-config"
		wxconfig_debug="${wxconfig_prefix}/${wxconfig_debug_name}"
	fi

	if [ -e ${wxconfig} ] ; then
		export WX_CONFIG=${wxconfig}
		export WX_CONFIG_NAME=${wxconfig_name}
		export WXBASE_CONFIG_NAME=${wxconfig_name}
		echo " * Using ${wxconfig}"
	elif [ -e ${wxconfig_debug} ] ; then
		export WX_CONFIG=${wxconfig_debug}
		export WX_CONFIG_NAME=${wxconfig_debug_name}
		export WXBASE_CONFIG_NAME=${wxconfig_debug_name}
		echo " * Using ${wxconfig_debug}"
	else
		echo "!!! $FUNCNAME: Error:  Can't find normal or debug version:"
		echo "!!! $FUNCNAME:         ${wxconfig} not found"
		echo "!!! $FUNCNAME:         ${wxconfig_debug} not found"
		case $1 in
			wxgtk)	 echo "!!! You need to emerge wxGTK with -no_wxgtk1 in your USE";;
			wxgtkd)	 echo "!!! You need to emerge wxGTK with -no_wxgtk1 in your USE";;
			gtk-ansi)  echo "!!! You need to emerge wxGTK with -no_wxgtk1 in your USE";;
			gtkd-ansi) echo "!!! You need to emerge wxGTK with -no_wxgtk1 in your USE";;

			wxgtk2)	 echo "!!! You need to emerge wxGTK with gtk2 in your USE";;
			wxgtk2d) echo "!!! You need to emerge wxGTK with gtk2 in your USE";;
			gtk2-ansi)  echo "!!! You need to emerge wxGTK with gtk2 in your USE";;
			gtk2d-ansi) echo "!!! You need to emerge wxGTK with gtk2 in your USE";;

			wxgtk2u)  echo "!!! You need to emerge wxGTK with unicode in your USE";;
			wxgtk2ud) echo "!!! You need to emerge wxGTK with unicode in your USE";;
			gtk2-unicode)  echo "!!! You need to emerge wxGTK with unicode in your USE";;
			gtk2d-unicode) echo "!!! You need to emerge wxGTK with unicode in your USE";;
		esac
		exit 1
	fi
}

