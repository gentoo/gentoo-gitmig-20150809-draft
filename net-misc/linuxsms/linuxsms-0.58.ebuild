# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/linuxsms/linuxsms-0.58.ebuild,v 1.5 2003/09/05 22:01:49 msterret Exp $

S=${WORKDIR}/${P}

DESCRIPTION="A console perl script for sending SMS to cell phones"
SRC_URI="mirror://sourceforge/linuxsms/${P}.tar.gz"
HOMEPAGE="http://linuxsms.sourceforge.net/"
KEYWORDS="x86 sparc"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=dev-lang/perl-5.6.1"

src_install () {
	dodir /opt/linuxsms
	into /opt/linuxsms
	dobin linuxsms

	insinto /etc/env.d
	doins ${FILESDIR}/97linuxsms

	doman linuxsms.1
	dodoc BUGS CHANGES COPYING INSTALL README README.ES TODO
}

pkg_postinst() {
	einfo "To run linuxsms /opt/linuxsms/bin/linuxsms"
}
