# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gringotts/gringotts-1.2.8.ebuild,v 1.2 2004/04/18 18:05:12 leonardop Exp $

DESCRIPTION="Utility that allows you to jot down sensitive data"
SRC_URI="http://devel.pluto.linux.it/projects/Gringotts/current/${P}.tar.bz2"
HOMEPAGE="http://devel.pluto.linux.it/projects/Gringotts/"
LICENSE="GPL-2"

IUSE=""
SLOT="0"
KEYWORDS="x86 ~ppc"

RDEPEND=">=dev-libs/libgringotts-1.2
	>=x11-libs/gtk+-2
	dev-libs/popt"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Remove deprecation flag, so it compiles using Gtk+ 2.4.
	sed -i -e 's:-DGTK_DISABLE_DEPRECATED::g' src/Makefile.in
}

src_install() {
	einstall

	# The FAQ and README documents shouldn't be gzip'd, as they need to be
	# available in plain format when they are called from the `Help' menu.
	#
	# dodoc FAQ README
	dodoc AUTHORS BUGS ChangeLog COPYING TODO
}
