# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/raidtools/raidtools-1.00.3-r1.ebuild,v 1.5 2004/01/21 21:15:44 bazik Exp $

inherit flag-o-matic

DESCRIPTION="Linux RAID 0/1/4/5 utilities"
SRC_URI="http://people.redhat.com/mingo/raidtools/${P}.tar.gz"
HOMEPAGE="http://people.redhat.com/mingo/raidtools/"

KEYWORDS="x86 amd64 ppc sparc hppa ~alpha ia64 ppc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	dev-libs/popt"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/mkraid.c-gcc33.patch
}

src_compile() {
	#Bug: 34712 (Nov 29 2003 -solar)
	filter-flags -fPIC
	econf || die
	make CFLAGS="${CFLAGS} -DMD_VERSION=\\\"${P}\\\"" || die
}

src_install() {
	make install ROOTDIR=${D} || die
	rm -rf ${D}/dev

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
