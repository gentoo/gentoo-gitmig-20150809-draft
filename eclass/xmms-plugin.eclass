# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/xmms-plugin.eclass,v 1.13 2005/02/12 00:45:26 eradicator Exp $
#
# Jeremy Huddleston <eradicator@gentoo.org>

# Usage:
# This eclass is used to create ebuilds for xmms plugins which are contained
# within the main xmms tarball.  Usage:

# PATCH_VER:
# GENTOO_URI:
# Set this variable if you want to use a gentoo specific patchset.  This adds
# ${GENTOO_URI}/xmms-${PV}-gentoo-patches-${PATCH_VER}.tar.bz2 to the SRC_URI

# PLUGIN_PATH:
# Set this variable to the plugin location you want to build.
# Example:
# PLUGIN_PATH="Input/mpg123"

# SONAME:
# Set this variable to the filename of the plugin that is copied over
# Example:
# SONAME="libmpg123.so"

inherit eutils

ECLASS=xmms-plugin
INHERITED="${INHERITED} ${ECLASS}"
DESCRIPTION="Xmms Plugin: ${PN}"
LICENSE="GPL-2"

SRC_URI="http://www.xmms.org/files/1.2.x/xmms-${PV}.tar.bz2
	 ${PATCH_VER:+${GENTOO_URI}/xmms-${PV}-gentoo-patches-${PATCH_VER}.tar.bz2}"

# Set S to something which exists
S="${WORKDIR}/xmms-${PV}"

if [[ -n "${PATCH_VER}" ]]; then
	RDEPEND="${RDEPEND+${RDEPEND}}${RDEPEND-${DEPEND}}"
	DEPEND="${DEPEND}
	        =sys-devel/automake-1.7*
		=sys-devel/autoconf-2.5*
		sys-devel/libtool"
fi

xmms-plugin_src_unpack() {
	unpack ${A}

	if [[ -n "${PATCH_VER}" ]]; then
		cd ${S}

		EPATCH_SUFFIX="patch"
		epatch ${WORKDIR}/patches

		export WANT_AUTOMAKE=1.7
		export WANT_AUTOCONF=2.5

		rm acinclude.m4
		libtoolize --force --copy || die "libtoolize --force --copy failed"

		[[ ! -f ltmain.sh ]] && ln -s ../ltmain.sh
		aclocal -I ${WORKDIR}/patches/m4 || die "aclocal failed"
		autoheader || die "autoheader failed"
		automake --gnu --add-missing --include-deps --force-missing --copy || die "automake failed"
		autoconf || die "autoconf failed"
	fi
}

xmms-plugin_src_compile() {
	filter-flags -fforce-addr -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE

	if use !amd64 && { use 3dnow || use mmx; }; then
		myconf="${myconf} --enable-simd"
	else
		myconf="${myconf} --disable-simd"
	fi

	econf ${myconf}
	cd ${S}/${PLUGIN_PATH}
	emake -j1 || die
}

xmms-plugin_src_install() {
	cd ${S}/${PLUGIN_PATH}
	make DESTDIR="${D}" install || die
}

EXPORT_FUNCTIONS src_unpack src_compile src_install
