# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/xmms-plugin.eclass,v 1.6 2004/10/20 02:39:44 eradicator Exp $
#
# Jeremy Huddleston <eradicator@gentoo.org>
#
# Usage:
# The main purpose of this eclass is to simplify installing xmms plugins
# which for the various players that support the xmms API (mainly xmms and
# bmp, but this can be expanded to noxmms as well).
#
# The package is assumed to work by default with xmms.  If it will not work
# with BMP, then set NOBMP=1 in the ebuild.
#
# Source Code:
# You have multiple methods with which to specify how we get the source code
# for the patckages.
#
# (1) - Separate tarballs
# If your package provides separate tarballs for the xmms and bmp plugins,
# then specify them in the XMMS_SRC_URI and BMP_SRC_URI variables.
# XMMS_SRC_URI="xmms-plugin.tar.bz2"
# BMP_SRC_URI="bmp-plugin.tar.bz2"
# BASE_SRC_URI="common-stuff.tar.bz2"
#
# (2) - xmms->bmp patch
# If you have a patch to turn an xmms plugin into a bmp plugin, specify it
# in the variable XMMS2BMP_PATCH:
# XMMS2BMP_PATCH="${FILESDIR}/${P}-xmms2bmp.patch"
#
# (3) - automated
# The eclass will try to do some sedage to get the plugin to work with bmp.
#
# Common patches:
# If you have patches that need to apply to both xmms and bmp sources,
# Place them in the PATCHES variable:
# PATCHES="${FILESDIR}/${P}-gcc34.patch ${FILESDIR}/${P}-config.patch"
#
# Source Location:
# By default, we assume a ${S} of ${XMMS_S} or ${BMP_S} for the two packages.
# These default to ${XMMS_WORKDIR}/${P} or ${BMP_WORKDIR}/${P}.
# ${XMMS_WORKDIR} and ${BMP_WORKDIR}/${P} default to ${WORKDIR}/xmms and
# ${WORKDIR}/bmp.  You may override ${*_S}, but not the ${*_WORKDIR}.
#
# Documentation:
# Set the DOCS variable to contain the documentation to be dodocd:
# DOCS="ChangeLog AUTHORS README"
#
# Install:
# Set the XMMS_PLUGIN_INSTALL variable to control how src_install works
# 'einstall' - use 'einstall' to install
# 'destdir'  - use 'make DESTDIR="${D}" install || die' to install
# 'doexe' - use 'doexe' to install
# destdir is default
#
# The 'myins_xmms' and 'myins_bmp' variables are used to add extra arguments
# to the install line.  They are optional for einstall and destdir, but they're
# required for doexe.  For doexe, you need to specify the plugin type in the
# 'xmms_plugin_type' variable' and the location of the plugin in the 'myins_*'
# variable.
#

inherit eutils libtool gnuconfig

ECLASS=xmms-plugin
INHERITED="${INHERITED} ${ECLASS}"

IUSE="${IUSE} xmms bmp"

DEPEND="bmp? ( >=media-sound/beep-media-player-0.9.7_rc2-r2 )
	xmms? ( media-sound/xmms )"
RDEPEND="bmp? ( >=media-sound/beep-media-player-0.9.7_rc2-r2 )
	xmms? ( media-sound/xmms )"

XMMS_WORKDIR="${WORKDIR}/xmms"
BMP_WORKDIR="${WORKDIR}/bmp"

# We don't use ${S}
S="${WORKDIR}"

if [ -z "${XMMS_S}" ]; then
	XMMS_S="${XMMS_WORKDIR}/${P}"
fi

if [ -z "${BMP_S}" ]; then
	BMP_S="${BMP_WORKDIR}/${P}"
fi

if [ -n "${BMP_SRC_URI}" -a -n "${XMMS_SRC_URI}" ]; then
	SRC_URI="${BASE_SRC_URI}
	         bmp? ( ${BMP_SRC_URI} )
	         xmms? ( ${XMMS_SRC_URI} )"
fi

xmms-plugin_src_unpack() {
	do_xmms && mkdir ${XMMS_WORKDIR}
	do_bmp && mkdir ${BMP_WORKDIR}

	if [ -n "${BMP_SRC_URI}" -a -n "${XMMS_SRC_URI}" ]; then
		if do_xmms; then
			cd ${XMMS_WORKDIR}
			for f in ${XMMS_SRC_URI} ${BASE_SRC_URI}; do
				XMMS_A="${XMMS_A} `basename ${f}`"
			done
			unpack ${XMMS_A}
		fi

		if do_bmp; then
			cd ${BMP_WORKDIR}
			for f in ${BMP_SRC_URI} ${BASE_SRC_URI}; do
				BMP_A="${BMP_A} `basename ${f}`"
			done
			unpack ${BMP_A}
		fi
	else
		if do_xmms; then
			cd ${XMMS_WORKDIR}
			unpack ${A}
		fi

		if do_bmp; then
			cd ${BMP_WORKDIR}
			unpack ${A}

			if [ -n "${XMMS2BMP_PATCH}" ]; then
				cd ${BMP_S}
				epatch ${XMMS2BMP_PATCH}
			else
				cd ${BMP_S}
				xmms2bmp_automate
			fi
		fi
	fi

	if [ -n "${PATCHES}" ]; then
		if do_xmms; then
			cd ${XMMS_S}
			epatch ${PATCHES}
		fi

		if do_bmp; then
			cd ${BMP_S}
			epatch ${PATCHES}
		fi
	fi

	if do_xmms; then
		cd ${XMMS_S}
		S="${XMMS_S}"
		elibtoolize
		gnuconfig_update
	fi

	if do_bmp; then
		cd ${BMP_S}
		S="${BMP_S}"
		elibtoolize
		gnuconfig_update
	fi
}

xmms-plugin_src_compile() {
	myconf="${myconf} --disable-static"

	if do_xmms; then
		cd ${XMMS_S}
		econf ${myconf} ${xmms_myconf} || die
		emake || die
	fi

	if do_bmp; then
		cd ${BMP_S}
		export FAKE_XMMS_VERSION=1.2.10
		econf ${myconf} ${bmp_myconf}|| die
		emake || die
	fi
}

xmms-plugin_src_install() {
	if [ -z "${XMMS_PLUGIN_INSTALL}" ]; then
		XMMS_PLUGIN_INSTALL="destdir"
	fi

	case ${XMMS_PLUGIN_INSTALL} in
	einstall)
		if do_xmms; then
			cd ${XMMS_S}
			einstall ${myins_xmms}
		fi

		if do_bmp; then
			cd ${BMP_S}
			einstall ${myins_bmp}
		fi
	;;
	destdir)
		if do_xmms; then
			cd ${XMMS_S}
			make DESTDIR="${D}" ${myins_xmms} install || die
		fi

		if do_bmp; then
			cd ${BMP_S}
			make DESTDIR="${D}" ${myins_bmp} install || die
		fi
	;;
	doexe)
		if do_xmms; then
			xmms-config --${xmms_plugin_type}-plugin-dir >& /dev/null || die "Invalid xmms_plugin_type specified"
			cd ${XMMS_S}
			exeinto `xmms-config --${xmms_plugin_type}-plugin-dir`
			doexe ${myins_xmms} || die
		fi

		if do_bmp; then
			beep-config --${xmms_plugin_type}-plugin-dir >& /dev/null || die "Invalid xmms_plugin_type specified"
			cd ${BMP_S}
			exeinto `beep-config --${xmms_plugin_type}-plugin-dir`
			doexe ${myins_bmp} || die
		fi
	;;
	*)
		die "Invalid XMMS_PLUGIN_INSTALL specified: ${XMMS_PLUGIN_INSTALL}"
	;;
	esac

	if [ -n "${DOCS}" ]; then
		dodoc ${DOCS}
	fi
}

xmms-plugin_pkg_postinst() {
	if use bmp && [ "${NOBMP}" = "1" ]; then
		ewarn "You have bmp in your USE flags, but this xmms plugin"
		ewarn "does not support bmp, sorry."
	fi
}

xmms2bmp_automate() {
	find . -name Makefile -o -name Makefile.in -o -name configure |
		xargs sed -i -e 's:xmms-config:beep-config:g' \
		             -e 's:libdir)/xmms:libdir)/bmp:g'
}

do_xmms() {
	use xmms
}

do_bmp() {
	use bmp && [ "${NOBMP}" != "1" ]
}

EXPORT_FUNCTIONS src_unpack src_compile src_install pkg_postinst
