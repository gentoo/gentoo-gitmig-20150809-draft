# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/raidtools/raidtools-1.00.3-r2.ebuild,v 1.4 2004/09/06 02:28:34 swegener Exp $

inherit flag-o-matic eutils

DESCRIPTION="Linux RAID 0/1/4/5 utilities"
SRC_URI="http://people.redhat.com/mingo/raidtools/${P}.tar.gz"
HOMEPAGE="http://people.redhat.com/mingo/raidtools/"

KEYWORDS="~x86 ~amd64 ppc ~sparc ~hppa ~alpha ~ia64 ~ppc64"
IUSE="build"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/libc
	dev-libs/popt"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/mkraid.c-gcc33.patch
	epatch ${FILESDIR}/${P}-2.6.Headers.patch

	# Buffer overflow fix
	sed -i "s:#define MAX_LINE_LENGTH\t\t\t(100):#define MAX_LINE_LENGTH (1000):" \
		common.h
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

	if ! use build
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
