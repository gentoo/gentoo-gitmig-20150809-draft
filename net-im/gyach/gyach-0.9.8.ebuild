# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gyach/gyach-0.9.8.ebuild,v 1.2 2004/07/15 00:13:27 agriffis Exp $

DESCRIPTION="GTK+-based Yahoo! chat client"
SRC_URI="http://www4.infi.net/~cpinkham/gyach/code/${P}.tar.gz"
HOMEPAGE="http://www4.infi.net/~cpinkham/gyach/"
KEYWORDS="x86 sparc ~ppc"
IUSE="gnome"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/libc
	=x11-libs/gtk+-2*"

src_compile() {
	./configure --host=${CHOST} --prefix=/usr || die
	emake || die
}

src_install() {
	make prefix=${D}/usr install || die
	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL README* TODO
	dodoc sample.*

	# install icon and desktop entry for gnome
	if use gnome ; then
		insinto /usr/share/pixmaps
		doins ${D}/usr/share/gyach/pixmaps/gyach-icon.xpm
		insinto /usr/share/gnome/apps/Internet
		doins ${FILESDIR}/gyach.desktop
	fi
}
