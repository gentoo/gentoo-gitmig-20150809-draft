# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gringotts/gringotts-1.2.8.ebuild,v 1.7 2004/11/22 18:00:25 leonardop Exp $

DESCRIPTION="Utility that allows you to jot down sensitive data"
HOMEPAGE="http://devel.pluto.linux.it/projects/Gringotts/"
SRC_URI="http://devel.pluto.linux.it/projects/Gringotts/current/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

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
	make DESTDIR=${D} install || die

	# The FAQ and README documents shouldn't be gzip'd, as they need to be
	# available in plain format when they are called from the `Help' menu.
	#
	# dodoc FAQ README
	dodoc AUTHORS BUGS ChangeLog TODO
}
