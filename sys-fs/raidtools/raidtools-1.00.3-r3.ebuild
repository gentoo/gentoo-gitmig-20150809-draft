# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/raidtools/raidtools-1.00.3-r3.ebuild,v 1.1 2005/02/12 02:08:22 vapier Exp $

inherit flag-o-matic eutils

DESCRIPTION="Linux RAID 0/1/4/5 utilities"
HOMEPAGE="http://people.redhat.com/mingo/raidtools/"
SRC_URI="http://people.redhat.com/mingo/raidtools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="build"

RDEPEND="virtual/libc
	dev-libs/popt"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc33.patch
	epatch "${FILESDIR}"/${P}-2.6.Headers.patch
	epatch "${FILESDIR}"/${P}-mkraid.patch
	epatch "${FILESDIR}"/${P}-s390x.patch
	epatch "${FILESDIR}"/${P}-raidstop.patch
	epatch "${FILESDIR}"/${P}-PIC.patch

	# Buffer overflow fix
	sed -i -e "/define MAX_LINE_LENGTH/s:100:1000:" common.h
	# Don't create device nodes (pisses off selinux) #73928
	sed -i \
		-e '/^CFLAGS/s:-O2:@CFLAGS@:' \
		-e "s:mknod:echo mknod means MonKey NOD:" \
		Makefile.in || die "sed Makefile.in failed"
}

src_compile() {
	econf || die "configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	make install ROOTDIR="${D}" || die

	if ! use build ; then
		doman *.8 *.5
		dodoc README *raidtab raidreconf-HOWTO reconf.notes retry summary
		dodoc Software-RAID.HOWTO/Software-RAID.HOWTO.txt
		dohtml Software-RAID.HOWTO/Software-RAID.HOWTO.html
		dohtml Software-RAID.HOWTO/Software-RAID.HOWTO.sgml
		docinto config
		dodoc *.sample
	fi
}
