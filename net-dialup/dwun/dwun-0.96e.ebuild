# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/dwun/dwun-0.96e.ebuild,v 1.1 2003/11/28 00:16:26 brandy Exp $

DESCRIPTION="Dialer Without a Useful Name (DWUN)"
HOMEPAGE="http://dwun.sourceforge.net/"
SRC_URI="http://download.sourceforge.net/dwun/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc"

src_unpack() {

	unpack ${A}
	cd ${S}
	sed -i -e "s:TODO QUICKSTART README UPGRADING ChangeLog COPYING AUTHORS::" Makefile.in

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
	exeinto /etc/init.d
	newexe ${FILESDIR}/dwun dwun

	dodoc AUTHORS ChangeLog COPYING INSTALL QUICKSTART README TODO UPGRADING

}

pkg_postinst() {

	einfo
	einfo 'Make sure you have "net-dialup/ppp" merged if you intend to use dwun'
	einfo "to control a standard PPP network link."
	einfo "See /usr/share/doc/${P}/QUICKSTART for instructions on"
	einfo "configuring dwun."
	einfo

}
