# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/xprobe/xprobe-0.0.2.ebuild,v 1.9 2005/01/29 05:12:52 dragonheart Exp $

inherit eutils

DESCRIPTION="Active OS fingerprinting tool"
SRC_URI="http://www.sys-security.com/archive/tools/X/${P}.tar.gz"
HOMEPAGE="http://www.sys-security.com/html/projects/X.html"

KEYWORDS="x86 ~sparc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/libpcap"
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

