# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/wasabi/wasabi-0.1.ebuild,v 1.2 2004/06/06 21:46:02 g2boojum Exp $

DESCRIPTION="Log parsing and notification program"
HOMEPAGE="http://www.gentoo.org/~lcars/wasabi"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-perl/Storable
	    dev-perl/BerkeleyDB"

src_install() {
	doman wasabi.8
	dosbin wasabi
	exeinto /etc/init.d
	newexe ${FILESDIR}/wasabi.init wasabi
	insinto /etc ; doins wasabi.conf
}

pkg_postinst() {
	einfo
	einfo "Remember that you have to emerge File-Tail when not using options"
	einfo "'set fifo' or 'set tail'"
	einfo
}
