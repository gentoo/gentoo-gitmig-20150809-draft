# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-oh323/asterisk-oh323-0.5.10.ebuild,v 1.1 2004/03/12 02:01:30 stkn Exp $

inherit eutils

DESCRIPTION="H.323 Support for the Asterisk soft PBX"
HOMEPAGE="http://www.inaccessnetworks.com/projects/asterisk-oh323/"
SRC_URI="http://www.inaccessnetworks.com/projects/asterisk-oh323/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-libs/pwlib-1.5.2-r2
	>=net-libs/openh323-1.12.2-r2
	>=net-misc/asterisk-0.7.2"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-Makefile.patch
	epatch ${FILESDIR}/${P}-asterisk-driver-Makefile.patch
}

src_compile() {
	# NOTRACE=1 is required (atm)
	# plugin won't work if this isn't set!
	# emake breaks version detection for pwlib and openh323
	make NOTRACE=1 || die
}

src_install() {
	make DESTDIR=${D} install || die
}
