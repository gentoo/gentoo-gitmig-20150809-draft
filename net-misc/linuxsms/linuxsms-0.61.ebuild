# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/linuxsms/linuxsms-0.61.ebuild,v 1.6 2004/07/15 02:57:37 agriffis Exp $

DESCRIPTION="A console perl script for sending SMS to cell phones"
SRC_URI="mirror://sourceforge/linuxsms/${P}.tar.gz"
HOMEPAGE="http://linuxsms.sourceforge.net/"
KEYWORDS="x86 ppc sparc "
LICENSE="GPL-2"
SLOT="0"
IUSE=""
DEPEND=">=dev-lang/perl-5.6.1"
RESTRICT="nomirror"

src_install () {
	into '/usr/local'
	dobin linuxsms

	doman linuxsms.1
	dodoc BUGS CHANGES COPYING INSTALL README README.ES TODO
}

pkg_postinst() {
	einfo "To run linuxsms, just type: linuxsms"
	einfo "Your config file will be located in ~/.linuxsms"
}
