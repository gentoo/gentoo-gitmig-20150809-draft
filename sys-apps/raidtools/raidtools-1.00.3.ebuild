# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/raidtools/raidtools-1.00.3.ebuild,v 1.2 2003/06/21 21:19:40 drobbins Exp $

DESCRIPTION="Linux RAID 0/1/4/5 utilities"
SRC_URI="http://people.redhat.com/mingo/raidtools/${P}.tar.gz"
HOMEPAGE="http://people.redhat.com/mingo/raidtools/"

KEYWORDS="x86 amd64 ~ppc ~sparc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	make CFLAGS="${CFLAGS} -DMD_VERSION=\\\"${P}\\\"" || die
}

src_install() {
	into /
	dosbin mkraid raidstart
	for x in raidstop raidhotadd raidhotremove raidsetfaulty
	do
		dosym raidstart /sbin/${x}
	done
	dosym mkraid /sbin/raid0run

	if [ -z "`use build`" ]
	then
		doman *.8 *.5
		dodoc README *raidtab raidreconf-HOWTO reconf.notes retry summary
		dodoc Software-RAID.HOWTO/Software-RAID.HOWTO.txt
		dohtml Software-RAID.HOWTO/Software-RAID.HOWTO.html
		dohtml Software-RAID.HOWTO/Software-RAID.HOWTO.sgml
		docinto config
		dodoc *.sample
	fi
}
