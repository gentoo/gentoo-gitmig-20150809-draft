# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/openhbci/openhbci-0.9.16.ebuild,v 1.7 2004/10/31 20:32:16 kloeri Exp $

inherit eutils

DESCRIPTION="Implementation of the HBCI protocol used by some banks"
HOMEPAGE="http://openhbci.sourceforge.net/"
SRC_URI="mirror://sourceforge/openhbci/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 alpha ppc ~sparc ~amd64"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.6
	>=sys-libs/libchipcard-0.8"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/openhbci_gcc34.gz
}

src_compile() {
	econf --with-chipcard=/usr || die "configure failed"
	emake || die "parallel make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc AUTHORS README TODO
}
