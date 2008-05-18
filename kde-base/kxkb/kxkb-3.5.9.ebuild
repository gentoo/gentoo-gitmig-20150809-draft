# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kxkb/kxkb-3.5.9.ebuild,v 1.7 2008/05/18 17:28:22 maekke Exp $

KMNAME=kdebase
EAPI="1"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-04.tar.bz2"

DESCRIPTION="KControl module for the X11 keyboard extension to configure and switch between keyboard mappings."
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

RDEPEND="${RDEPEND}
		|| ( x11-misc/xkeyboard-config x11-misc/xkbdata )
		x11-apps/setxkbmap"

KMEXTRACTONLY="${KMEXTRACTONLY}
	kdm/configure.in.in"

src_unpack() {
	kde-meta_src_unpack

	epatch "${WORKDIR}/patches/kdm-3.5-noimake.patch"

	# Remove reference to kde.desktop in AC_OUTPUT to allow building with
	# autoconf 2.59d
	sed -i -e '/kde.desktop/ s:^:#:g' "${S}/kdm/configure.in.in"
}
