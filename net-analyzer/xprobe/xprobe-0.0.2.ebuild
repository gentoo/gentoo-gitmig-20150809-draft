# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/xprobe/xprobe-0.0.2.ebuild,v 1.8 2005/01/01 15:37:46 weeve Exp $

inherit eutils

DESCRIPTION="Active OS fingerprinting tool"
SRC_URI="http://www.sys-security.com/archive/tools/X/${P}.tar.gz"
HOMEPAGE="http://www.sys-security.com/html/projects/X.html"

KEYWORDS="x86 ~sparc"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=net-libs/libpcap-0.6.1"
IUSE=""

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch || die "epatch failed"
}

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS CREDITS LICENSE
	dodoc Changelog TODO README
}

