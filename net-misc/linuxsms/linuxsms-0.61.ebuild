# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/linuxsms/linuxsms-0.61.ebuild,v 1.1 2003/03/27 01:23:53 zwelch Exp $

S=${WORKDIR}/${P}

DESCRIPTION="A console perl script for sending SMS to cell phones"
SRC_URI="mirror://sourceforge/linuxsms/${P}.tar.gz"
HOMEPAGE="http://linuxsms.sourceforge.net/"
KEYWORDS="x86 ppc sparc arm"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=dev-lang/perl-5.6.1"

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
