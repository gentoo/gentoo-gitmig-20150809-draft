# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/scanlogd/scanlogd-2.2.ebuild,v 1.14 2005/01/04 18:25:28 hansmi Exp $

IUSE=""
DESCRIPTION="Scanlogd - detects and logs TCP port scans"
SRC_URI="http://www.openwall.com/scanlogd/${P}.tar.gz"
HOMEPAGE="http://www.openwall.com/scanlogd/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc ~ppc"

DEPEND="virtual/libc"

src_compile() {
	make linux || die
}

src_install() {
	dosbin scanlogd
	doman scanlogd.8

	exeinto /etc/init.d ; newexe ${FILESDIR}/scanlogd.rc scanlogd
}

pkg_postinst() {
	einfo "Before you can run scanlogd you need to create the user "
	einfo "scanlog by running the following command"
	einfo "adduser -s /bin/false scanlogd"
	einfo "You can start the scanlogd monitoring program at boot by running"
	einfo "rc-update add scanlogd default"
}
