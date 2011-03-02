# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gyach/gyach-0.9.8.ebuild,v 1.4 2011/03/02 20:13:13 signals Exp $

EAPI=2

DESCRIPTION="GTK+-based Yahoo! chat client"
SRC_URI="http://www4.infi.net/~cpinkham/gyach/code/${P}.tar.gz"
HOMEPAGE="http://www4.infi.net/~cpinkham/gyach/"
KEYWORDS="~ppc sparc x86"
IUSE="gnome"
LICENSE="GPL-2"
SLOT="0"

DEPEND="x11-libs/gtk+:2"

src_configure() {
	./configure --host=${CHOST} --prefix=/usr || die
}

src_compile() {
	emake || die
}

src_install() {
	make prefix="${D}"/usr install || die
	dodoc AUTHORS BUGS ChangeLog INSTALL README* TODO
	dodoc sample.*

	# install icon and desktop entry for gnome
	if use gnome ; then
		insinto /usr/share/pixmaps
		doins "${D}"/usr/share/gyach/pixmaps/gyach-icon.xpm
		insinto /usr/share/gnome/apps/Internet
		doins "${FILESDIR}"/gyach.desktop
	fi
}
