# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgtop/libgtop-2.14.1.ebuild,v 1.8 2006/08/16 14:06:50 corsair Exp $

inherit gnome2 eutils autotools

DESCRIPTION="A library that provides top functionality to applications"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~alpha amd64 hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE="gdbm static X"

RDEPEND=">=dev-libs/glib-2.6
	gdbm? ( sys-libs/gdbm )
	dev-libs/popt"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README copyright.txt"

src_unpack() {
	gnome2_src_unpack

	epatch ${FILESDIR}/${P}-as-needed.patch
	eautoreconf
}

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable static) $(use_with gdbm libgtop-inodedb) \
		$(use_with X x)"
}
