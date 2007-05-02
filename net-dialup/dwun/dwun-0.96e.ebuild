# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/dwun/dwun-0.96e.ebuild,v 1.7 2007/05/02 00:17:24 genone Exp $

DESCRIPTION="Dialer Without a Useful Name (DWUN)"
HOMEPAGE="http://dwun.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""

src_unpack() {
	unpack ${A}

	sed -i -e "s:TODO QUICKSTART README UPGRADING ChangeLog COPYING AUTHORS::" "${S}/Makefile.in"
}

src_compile() {
	econf --with-docdir=doc/${P} || die "econf failed."
	emake || die "parallel make failed."
}

src_install() {
	einstall || die "install failed."

	insinto /etc
	newins doc/examples/complete-rcfile dwunrc
	newins debian/dwunauth dwunauth
	newinitd "${FILESDIR}/dwun" dwun

	dodoc AUTHORS ChangeLog QUICKSTART README TODO UPGRADING
}

pkg_postinst() {
	elog
	elog 'Make sure you have "net-dialup/ppp" merged if you intend to use dwun'
	elog "to control a standard PPP network link."
	elog "See /usr/share/doc/${P}/QUICKSTART for instructions on"
	elog "configuring dwun."
	elog
}
