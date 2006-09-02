# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ophcrack/ophcrack-2.3.1.ebuild,v 1.1 2006/09/02 12:27:23 ikelos Exp $

inherit eutils

DESCRIPTION="A time-memory-trade-off-cracker"
HOMEPAGE="http://ophcrack.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
		 !ophsmall? ( http://lasecwww.epfl.ch/SSTIC04-5k.zip )
		 ophsmall? ( http://lasecwww.epfl.ch/SSTIC04-10k.zip )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="ophsmall"

DEPEND="dev-libs/openssl
		net-libs/netwib"
RDEPEND=""

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-linuxtools-install-path.patch
}

src_install() {
	make install DESTDIR=${D}

	TABLENAME="5000"
	use ophsmall && TABLENAME="10000"

	dodir /usr/share/${PN}/${TABLENAME}
	mv ${WORKDIR}/table* ${D}/usr/share/${PN}/${TABLENAME}
}
