# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/eclipse-ext.eclass,v 1.6 2004/07/28 12:59:46 karltk Exp $

# Author: Karl Trygve Kalleberg <karltk@gentoo.org>
# Maintainer: Karl Trygve Kalleberg <karltk@gentoo.org>

inherit base
ECLASS="eclipse-ext"
INHERITED="${INHERITED} ${ECLASS}"
IUSE="${IUSE}"
SLOT="${SLOT}"

eclipse_ext_type="source"
eclipse_ext_slot="0"
eclipse_ext_basedir="/usr/lib-eclipse-${eclipse_ext_slot}"

# ---------------------------------------------------------------------------
# @public require-slot
#
# Ensure that an Eclipse SDK is actually available for the given slot;
# sets internal state to install for selected slot.
#
# @param $1 - SLOT of Eclipse SDK that required for this ebuild
# alternatively
# @return 0 - all is well, non-zero otherwise
# ---------------------------------------------------------------------------
function eclipse-ext_require-slot {
	# karltk: Should probably add support for a span of slots
	local slot=$1
	if [ ! -d /usr/lib/eclipse-${slot} ] ; then
		eerror "Cannot find any installed Eclipse SDK for slot ${slot}"
		return 1
	fi

	eclipse_ext_slot=${slot}
	eclipse_ext_basedir="/usr/lib-eclipse-${eclipse_ext_slot}"

	return 0
}

# ---------------------------------------------------------------------------
# @public create-plugin-layout
#
# Create directory infrastructure for binary-only plugins so that the installed
# Eclipse SDK will see them. Sets internal state for installing as source or
# binary.
#
# @param $1 - type of ebuild, "source" or "binary"
# @return   - nothing
# ---------------------------------------------------------------------------
function eclipse-ext_create-ext-layout {
	local type=$1
	if [ "${type}" == "binary" ] ; then
		eclipse_ext_basedir="/opt/eclipse-extensions-${eclipse_ext_slot}/eclipse"
		dodir ${eclipse_ext_basedir}/{features,plugins}
		touch ${D}/${eclipse_ext_basedir}/.eclipseextension
	else
		eclipse_ext_basedir="/usr/lib/eclipse-${eclipse_ext_slot}"
		dodir ${eclipse_ext_basedir}/{features,plugins}
	fi
}

# ---------------------------------------------------------------------------
# @public install-features
#
# Installs one or multiple features into the plugin directory for the required
# Eclipse SDK.
#
# Note: You must call require-slot prior to calling install-features. If your
# ebuild is for a binary-only plugin, you must also call create-plugin-layout
# prior to calling install-features.
#
# @param $* - feature directories
# @return 0 - if all is well
#         1 - if require-slot was not called
# ---------------------------------------------------------------------------
function eclipse-ext_install-features {

	if [ ${eclipse_ext_slot} == 0 ] ; then
		eerror "You must call require-slot prior to calling ${FUNCNAME}!"
		return 1
	fi

	for x in $* ; do
		if [ -d "$x" ] && [ -f $x/feature.xml ] ; then
			cp -a $x ${D}/${eclipse_ext_basedir}/features
		else
			eerror "$x not a feature directory!"
		fi
	done
}

# ---------------------------------------------------------------------------
# @public install-plugins
#
# Installs one or multiple plugins into the plugin directory for the required
# Eclipse SDK.
#
# Note: You must call require-slot prior to calling install-features. If your
# ebuild is for a binary-only plugin, you must also call create-plugin-layout
# prior to calling install-features.
#
# @param $* - plugin directories
# @return   - nothing
# ---------------------------------------------------------------------------

function eclipse-ext_install-plugins {

	if [ ${eclipse_ext_slot} == 0 ] ; then
		eerror "You must call require-slot prior to calling ${FUNCNAME}!"
		return 1
	fi

	for x in $* ; do
		if [ -d "$x" ] && ( [ -f "$x/plugin.xml" ] || [ -f "$x/fragment.xml" ] ) ; then
			cp -a $x ${D}/${eclipse_ext_basedir}/plugins
		else
			eerror "$x not a plugin directory!"
		fi
	done
}

function eclipse-ext_pkg_postinst() {
	einfo "For tips, tricks and general info on running Eclipse on Gentoo, go to:"
	einfo "http://dev.gentoo.org/~karltk/projects/eclipse/"
}

function pkg_postinst() {
	eclipse-ext_pkg_postinst
}
