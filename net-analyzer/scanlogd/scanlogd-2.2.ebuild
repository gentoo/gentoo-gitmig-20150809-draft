# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: mike polniak <mikpolniak@adelphia.net>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/scanlogd/scanlogd-2.2.ebuild,v 1.2 2002/04/27 23:34:20 bangert Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Scanlogd- detects and logs TCP port scans"
SRC_URI="http://www.openwall.com/scanlogd/${P}.tar.gz"
HOMEPAGE="http://www.openwall.com/scanlogd"

DEPEND="virtual/glibc"

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
	einfo "Before you can run scanlogd you need too make the user scanlog by running the following command"                                                               
        einfo "adduser -s /bin/false scanlogd"
	einfo "You can start the scanlogd monitoring program on boot time by running"
        einfo "rc-update add scanlogd default"                                       
}                                                                               
