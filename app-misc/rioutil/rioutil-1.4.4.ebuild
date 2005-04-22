# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rioutil/rioutil-1.4.4.ebuild,v 1.11 2005/04/22 09:03:10 dragonheart Exp $

inherit eutils

DESCRIPTION="Command line tool for transfering mp3s to and from a Rio 600, 800, Rio Riot, and Nike PSA/Play"
HOMEPAGE="http://rioutil.sourceforge.net/"
SRC_URI="mirror://sourceforge/rioutil/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="sys-libs/zlib
	virtual/libc
	dev-libs/libusb"

src_unpack() {
	unpack ${A} || die 'Failed to unpack!'
	cd "${S}"
	epatch "${FILESDIR}/${P}-26headers.patch"
}

src_compile() {
	econf --with-usbdevfs || die
	emake || die "emake failure"
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
