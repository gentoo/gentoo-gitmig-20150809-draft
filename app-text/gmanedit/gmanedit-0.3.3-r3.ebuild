# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gmanedit/gmanedit-0.3.3-r3.ebuild,v 1.1 2003/04/21 19:51:26 liquidx Exp $

inherit eutils

DESCRIPTION="Gnome based manpage editor"
SRC_URI="http://gmanedit.sourceforge.net/files/${P}.tar.bz2"
HOMEPAGE="http://gmanedit.sourceforge.net/"

KEYWORDS="~x86 ~sparc"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="virtual/x11
	>=gnome-base/gnome-libs-1.4.1.4"

S=${WORKDIR}/${P}.orig

src_compile() {
	epatch ${FILESDIR}/${P}-xterm.patch
	econf --disable-nls
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog TODO README NEWS
}
