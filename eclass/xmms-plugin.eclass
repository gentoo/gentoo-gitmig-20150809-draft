# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/xmms-plugin.eclass,v 1.7 2004/10/21 04:38:25 eradicator Exp $
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

if [ "${NOXMMS}" != "1" ]; then
	IUSE="${IUSE} xmms"
	DEPEND="${DEPEND}
		xmms? ( media-sound/xmms )"

	RDEPEND="${RDEPEND}
		 xmms? ( media-sound/xmms )"

	if [ -n "${BMP2XMMS_PATCH}" ]; then
		SRC_URI="${SRC_URI}
			 xmms? ( ${XMMS_SRC_URI} 
			         ${BMP_SRC_URI} )"
	elif [ -n "${XMMS_SRC_URI}" ]; then
		SRC_URI="${SRC_URI}
			 xmms? ( ${XMMS_SRC_URI} )"
	fi

	XMMS_WORKDIR="${WORKDIR}/xmms"
	if [ -z "${XMMS_S}" ]; then
		XMMS_S="${XMMS_WORKDIR}/${P}"
	fi
fi

if [ "${NOBMP}" != "1" ]; then
	IUSE="${IUSE} bmp"
	DEPEND="${DEPEND}
		bmp? ( >=media-sound/beep-media-player-0.9.7_rc2-r2 
		       dev-util/pkgconfig )"

	RDEPEND="${RDEPEND}
		bmp? ( >=media-sound/beep-media-player-0.9.7_rc2-r2 )"

	if [ -n "${XMMS2BMP_PATCH}" ]; then
		SRC_URI="${SRC_URI}
			 bmp? ( ${XMMS_SRC_URI} 
			         ${BMP_SRC_URI} )"
	elif [ -n "${BMP_SRC_URI}" ]; then
		SRC_URI="${SRC_URI}
			 bmp? ( ${BMP_SRC_URI} )"
	fi

	BMP_WORKDIR="${WORKDIR}/bmp"
	if [ -z "${BMP_S}" ]; then
		BMP_S="${BMP_WORKDIR}/${P}"
	fi
fi

SRC_URI="${BASE_SRC_URI} ${SRC_URI}"

# Set S to something which exists
S="${WORKDIR}"

xmms-plugin_src_unpack() {
	if do_xmms; then
		mkdir ${XMMS_WORKDIR}
		cd ${XMMS_WORKDIR}

		XMMS_A=""
		if [ -z "${BASE_SRC_URI}${XMMS_SRC_URI}${BMP_SRC_URI}" ]; then
			XMMS_A=${A}
		elif [ -n "${BMP2XMMS_PATCH}" ]; then
			for f in ${XMMS_SRC_URI} ${BMP_SRC_URI} ${BASE_SRC_URI}; do
				XMMS_A="${XMMS_A} `basename ${f}`"
			done
		else
			for f in ${XMMS_SRC_URI} ${BASE_SRC_URI}; do
				XMMS_A="${XMMS_A} `basename ${f}`"
			done
		fi
		
		unpack ${XMMS_A}

		cd ${XMMS_S}
		if [ -n "${PATCHES}" ]; then
			epatch ${PATCHES}
		fi
		if [ -n "${BMP2XMMS_PATCH}" ]; then
			epatch ${BMP2XMMS_PATCH}
		fi

		elibtoolize
		gnuconfig_update
	fi

	if do_bmp; then
		mkdir ${BMP_WORKDIR}
		cd ${BMP_WORKDIR}

		BMP_A=""
		if [ -z "${BASE_SRC_URI}${XMMS_SRC_URI}${BMP_SRC_URI}" ]; then
			BMP_A=${A}
		elif [ -n "${XMMS2BMP_PATCH}" ]; then
			for f in ${XMMS_SRC_URI} ${BMP_SRC_URI} ${BASE_SRC_URI}; do
				BMP_A="${BMP_A} `basename ${f}`"
			done
		else
			for f in ${BMP_SRC_URI} ${BASE_SRC_URI}; do
				BMP_A="${BMP_A} `basename ${f}`"
			done
		fi
		
		unpack ${BMP_A}

		cd ${BMP_S}
		if [ -n "${PATCHES}" ]; then
			epatch ${PATCHES}
		fi
		if [ -n "${XMMS2BMP_PATCH}" ]; then
			epatch ${XMMS2BMP_PATCH}
		elif [ -z "${BMP_SRC_URI}" ]; then
			xmms2bmp_automate
		fi

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
		econf ${myconf} ${bmp_myconf} || die
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

xmms2bmp_automate() {
	find . -name Makefile -o -name Makefile.in -o -name configure |
		xargs sed -i -e 's:xmms-config:beep-config:g' \
		             -e 's:libdir)/xmms:libdir)/bmp:g' \
		             -e 's:-lxmms:-lbeep:g'
}

do_xmms() {
	use xmms && [ "${NOXMMS}" != "1" ]
}

do_bmp() {
	use bmp && [ "${NOBMP}" != "1" ]
}

EXPORT_FUNCTIONS src_unpack src_compile src_install pkg_postinst
