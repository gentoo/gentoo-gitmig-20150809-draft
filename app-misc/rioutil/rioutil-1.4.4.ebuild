# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rioutil/rioutil-1.4.4.ebuild,v 1.7 2004/07/20 17:08:52 plasmaroo Exp $

DESCRIPTION="Command line tool for transfering mp3s to and from a Rio 600, 800, Rio Riot, and Nike PSA/Play"
HOMEPAGE="http://rioutil.sourceforge.net/"
SRC_URI="mirror://sourceforge/rioutil/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND="sys-libs/zlib
	virtual/libc"

inherit eutils

src_unpack() {
	unpack ${A} || die 'Failed to unpack!'
	cd ${S}
	epatch ${FILESDIR}/${P}-26headers.patch || die 'Failed to apply 2.6 headers patch!'
}

src_compile() {
	local myconf="--with-usbdevfs"

	econf ${myconf} || die "econf failed"
	emake || die "compile failure"
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
