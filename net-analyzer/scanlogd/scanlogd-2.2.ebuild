# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/scanlogd/scanlogd-2.2.ebuild,v 1.9 2003/02/13 13:50:20 vapier Exp $

DESCRIPTION="Scanlogd- detects and logs TCP port scans"
SRC_URI="http://www.openwall.com/scanlogd/${P}.tar.gz"
HOMEPAGE="http://www.openwall.com/scanlogd/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc "

DEPEND="virtual/glibc"

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
