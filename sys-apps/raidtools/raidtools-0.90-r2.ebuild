# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Achim Gottinger <achim@gentoo.org>, Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/raidtools/raidtools-0.90-r2.ebuild,v 1.2 2001/08/30 05:12:09 drobbins Exp $

S=${WORKDIR}/raidtools-0.90
DESCRIPTION="Linux RAID 0/1/4/5 utilities"
SRC_URI="http://people.redhat.com/mingo/raid-patches/raidtools-dangerous-0.90-20000116.tar.gz"
DEPEND="virtual/glibc"

src_compile() {
    ./configure || die
    cp Makefile Makefile.orig
    sed -e "s/-O2//" -e "s/-g//" Makefile.orig > Makefile
    emake || die
}

src_install() {
    into /
    dosbin mkraid raidstart mkpv
    for x in raidstop raidhotadd raidhotremove raidsetfaulty
    do
		dosym raidstart /sbin/${x}
    done
    dosym mkraid /sbin/raid0run

	if [ -z "`use build`" ]
	then
		doman *.8 *.5
		dodoc COPYING README
		docinto txt
		dodoc Software-RAID.HOWTO/Software-RAID.HOWTO.txt
		docinto html
		dodoc Software-RAID.HOWTO/Software-RAID.HOWTO.html
		docinto sgml
		dodoc Software-RAID.HOWTO/Software-RAID.HOWTO.sgml
		docinto config
		dodoc *.sample
	fi
}

