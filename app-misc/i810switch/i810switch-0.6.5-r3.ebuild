# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/i810switch/i810switch-0.6.5-r3.ebuild,v 1.1 2012/07/31 15:49:34 cedk Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A utility for switching the LCD and external VGA displays on and off"
HOMEPAGE="http://www16.plala.or.jp/mano-a-mano/i810switch.html"
SRC_URI="http://www16.plala.or.jp/mano-a-mano/i810switch/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/pciutils"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/i810switch-macbook-support.patch
	epatch "${FILESDIR}"/i810switch-ldflags.patch
	emake clean
}

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO
}

pkg_postinst() {
	einfo "To allow non-root users to use i810switch run:"
	einfo " chmod u+s /usr/bin/i810switch"
}
