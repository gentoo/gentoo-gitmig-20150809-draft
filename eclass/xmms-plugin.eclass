# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/xmms-plugin.eclass,v 1.14 2005/02/12 02:15:05 eradicator Exp $
#
# Jeremy Huddleston <eradicator@gentoo.org>

# Usage:
# This eclass is used to create ebuilds for xmms plugins which are contained
# within the main xmms tarball.  Usage:

# PATCH_VER:
# M4_VER:
# GENTOO_URI:
GENTOO_URI=${GENTOO_URI-"http://dev.gentoo.org/~eradicator/xmms"}
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
	 ${M4_VER:+${GENTOO_URI}/xmms-${PV}-gentoo-m4-${M4_VER}.tar.bz2}
	 ${PATCH_VER:+${GENTOO_URI}/xmms-${PV}-gentoo-patches-${PATCH_VER}.tar.bz2}"

# Set S to something which exists
S="${WORKDIR}/xmms-${PV}"

RDEPEND="${RDEPEND+${RDEPEND}}${RDEPEND-${DEPEND}}"
DEPEND="${DEPEND}
        =sys-devel/automake-1.7*
	=sys-devel/autoconf-2.5*
	sys-devel/libtool"

xmms-plugin_src_unpack() {
	unpack ${A}

	cd ${S}
	if [[ -n "${PATCH_VER}" ]]; then

		EPATCH_SUFFIX="patch"
		epatch ${WORKDIR}/patches
	fi

	cd ${S}/${PLUGIN_PATH}
	sed -i -e 's:-I$(top_srcdir)::g' \
	       -e "s:\$(top_builddir)/libxmms/libxmms.la:/usr/$(get_libdir)/libxmms.la:g" \
	       Makefile.am

	cd ${S}

	export WANT_AUTOMAKE=1.7
	export WANT_AUTOCONF=2.5

	libtoolize --force --copy || die "libtoolize --force --copy failed"

	if [[ -n "${M4_VER}" ]]; then
		rm acinclude.m4
		aclocal -I ${WORKDIR}/m4 || die "aclocal failed"
	else
		aclocal || die "aclocal failed"
	fi
	autoheader || die "autoheader failed"
	automake --gnu --add-missing --include-deps --force-missing --copy || die "automake failed"
	autoconf || die "autoconf failed"
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
