# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/nbench/nbench-2.1.ebuild,v 1.5 2004/01/18 19:55:10 tuxus Exp $

MY_P="${PN}-byte-${PV}"
DESCRIPTION="Linux/Unix of release 2 of BYTE Magazine's BYTEmark benchmark"
HOMEPAGE="http://www.tux.org/~mayer/linux/bmark.html"
SRC_URI="http://www.tux.org/~mayer/linux/${MY_P}.tar.gz"
LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 amd64 ~sparc ~mips"
IUSE=""

DEPEND="virtual/glibc"
#RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
}

src_compile() {

	D=${S}/ dosed 's:$compiler -v\( 2>&1 | sed -e "/version/!d"\|\):$compiler -dumpversion:' sysinfo.sh
	D=${S}/ dosed 's:inpath="NNET.DAT":inpath="/usr/share/nbench/NNET.DAT":' nbench1.h

	make CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin nbench
	insinto /usr/share/nbench
	doins NNET.DAT

	dodoc Changes README* bdoc.txt
}


