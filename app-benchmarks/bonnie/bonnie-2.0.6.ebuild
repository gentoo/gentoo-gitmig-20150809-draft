# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/bonnie/bonnie-2.0.6.ebuild,v 1.17 2005/01/01 12:03:11 eradicator Exp $

inherit eutils

DESCRIPTION="Performance Test of Filesystem I/O using standard C library calls."
HOMEPAGE="http://www.textuality.com/bonnie/"
SRC_URI="http://www.textuality.com/bonnie/bonnie.tar.gz"

LICENSE="bonnie"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ~ia64 amd64 ~mips ppc64"
IUSE=""
DEPEND=""
RDEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack ${A} || die
	epatch ${FILESDIR}/bonnie_man.patch
	epatch ${FILESDIR}/Makefile.patch
}

src_compile() {
	make SYSFLAGS="${CFLAGS}" || die
	mv Bonnie bonnie
}

src_install() {
	doman bonnie.1
	dodoc Instructions
	dobin bonnie
}
