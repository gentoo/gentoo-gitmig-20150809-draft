# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/raidtools/raidtools-0.90-r2.ebuild,v 1.6 2004/07/15 03:41:16 agriffis Exp $

S=${WORKDIR}/raidtools-0.90
DESCRIPTION="Linux RAID 0/1/4/5 utilities"
SRC_URI="http://people.redhat.com/mingo/raid-patches/raidtools-dangerous-0.90-20000116.tar.gz"
DEPEND="virtual/libc"
HOMEPAGE="http://people.redhat.com/mingo/raidtools/"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE="build"
SLOT="0"
LICENSE="GPL-2"

src_compile() {
	./configure || die
	cp Makefile Makefile.orig
	sed -e "s/-O2//" -e "s/ -g/ /" Makefile.orig > Makefile
	#emake appears to kill this every now and then (drobbins, 15 Sep 2002)
	make || die
}

src_install() {
	into /
	dosbin mkraid raidstart mkpv
	for x in raidstop raidhotadd raidhotremove raidsetfaulty
	do
		dosym raidstart /sbin/${x}
	done
	dosym mkraid /sbin/raid0run

	if ! use build
	then
		doman *.8 *.5
		dodoc COPYING README
		docinto txt
		dodoc Software-RAID.HOWTO/Software-RAID.HOWTO.txt
		dohtml Software-RAID.HOWTO/Software-RAID.HOWTO.html
		dohtml Software-RAID.HOWTO/Software-RAID.HOWTO.sgml
		docinto config
		dodoc *.sample
	fi
}
