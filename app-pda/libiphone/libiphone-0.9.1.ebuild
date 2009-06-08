# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libiphone/libiphone-0.9.1.ebuild,v 1.1 2009/06/08 23:16:11 chainsaw Exp $

EAPI=1
DESCRIPTION="Support library to communicate with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://matt.colyer.name/projects/iphone-linux/index.php?title=Main_Page"
SRC_URI="http://cloud.github.com/downloads/MattColyer/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
DEPEND="dev-util/pkgconfig
	${RDEPEND}"
RDEPEND="app-pda/libplist
	=dev-libs/glib-2*
	dev-libs/libgcrypt
	net-libs/gnutls
	sys-fs/fuse
	virtual/libusb:0"

src_install() {
	make DESTDIR="${D}" install || die
}
