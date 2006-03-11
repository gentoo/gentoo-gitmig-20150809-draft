# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/scanlogd/scanlogd-2.2.6.ebuild,v 1.1 2006/03/11 18:02:45 vanquirius Exp $

inherit eutils

IUSE=""
DESCRIPTION="Scanlogd - detects and logs TCP port scans"
SRC_URI="http://www.openwall.com/scanlogd/${P}.tar.gz"
HOMEPAGE="http://www.openwall.com/scanlogd/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="virtual/libc"

pkg_setup() {
	enewgroup scanlogd
	enewuser scanlogd -1 -1 /dev/null scanlogd
}

src_compile() {
	make linux || die
}

src_install() {
	dosbin scanlogd
	doman scanlogd.8

	exeinto /etc/init.d ; newexe ${FILESDIR}/scanlogd.rc scanlogd
}

pkg_postinst() {
	einfo "You can start the scanlogd monitoring program at boot by running"
	einfo "rc-update add scanlogd default"
}
