# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgtop/libgtop-2.14.6.ebuild,v 1.12 2007/02/06 10:26:43 uberlord Exp $

WANT_AUTOMAKE="1.9"
inherit gnome2 eutils autotools

DESCRIPTION="A library that provides top functionality to applications"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="gdbm X"

RDEPEND=">=dev-libs/glib-2.6
	gdbm? ( sys-libs/gdbm )
	dev-libs/popt"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} $(use_with gdbm libgtop-inodedb) $(use_with X x)"
}

src_unpack() {
	gnome2_src_unpack

	if use x86-fbsd ; then
		epatch "${FILESDIR}/${P}"-fbsd.patch
		cp aclocal.m4 old_macros.m4
		AT_M4DIR="." eautoreconf
	fi
}
