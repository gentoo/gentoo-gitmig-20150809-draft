# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/scanlogd/scanlogd-2.2.ebuild,v 1.5 2002/08/14 12:12:28 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Scanlogd- detects and logs TCP port scans"
SRC_URI="http://www.openwall.com/scanlogd/${P}.tar.gz"
HOMEPAGE="http://www.openwall.com/scanlogd"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	make linux || die
}
 
src_install()  {
	mkdir -p ${D}usr/sbin  
	cp scanlogd ${D}usr/sbin || die
	
	doman scanlogd.8

	exeinto /etc/init.d ; newexe ${FILESDIR}/scanlogd.rc scanlogd
}  

pkg_postinst () {
	einfo "Before you can run scanlogd you need to create the user "
	einfo "scanlog by running the following command"
	einfo "adduser -s /bin/false scanlogd"
	einfo "You can start the scanlogd monitoring program at boot by running"
	einfo "rc-update add scanlogd default"				       
}									       
