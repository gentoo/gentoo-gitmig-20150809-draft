# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/raidtools/raidtools-0.90-r1.ebuild,v 1.4 2000/10/27 23:56:30 drobbins Exp $

P=raidtools-0.90-1
A=raidtools-dangerous-0.90-20000116.tar.gz
S=${WORKDIR}/raidtools-0.90
DESCRIPTION="Linux RAID 0/1/4/5 utilities"
SRC_URI="http://people.redhat.com/mingo/raid-patches/"${A}

src_compile() {                           
    try ./configure 
    cp Makefile Makefile.orig
    sed -e "s/-O2//" -e "s/-g//" Makefile.orig > Makefile
    try make
}

src_install() {                               
    into /
    dosbin mkraid raidstart mkpv 
    for x in raidstop raidhotadd raidhotremove
    do
	dosym raidstart /sbin/${x}
    done
    dosym mkraid /sbin/raid0run
    doman *.8 *.5
    dodoc COPYING README Software-RAID.HOWTO/Software-RAID.HOWTO.txt
    docinto html
    dodoc Software-RAID.HOWTO/*.html
    docinto config
    dodoc *.sample
}
pkg_postinst() {
    echo "Creating Raid-devices..."

    for i in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
    do
	if [ ! -e ${ROOT}/dev/md$$i ]
	then
	    mknod -m 0600 ${ROOT}/dev/md$$i b 9 $$i
	fi
    done         
}
