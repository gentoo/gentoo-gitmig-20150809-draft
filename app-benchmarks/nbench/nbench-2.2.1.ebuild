# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/nbench/nbench-2.2.1.ebuild,v 1.1 2004/11/07 23:32:37 morfic Exp $

MY_P="${PN}-byte-${PV}"
DESCRIPTION="Linux/Unix of release 2 of BYTE Magazine's BYTEmark benchmark"
HOMEPAGE="http://www.tux.org/~mayer/linux/bmark.html"
SRC_URI="http://www.tux.org/~mayer/linux/${MY_P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 amd64 sparc ~mips ppc"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${MY_P}

src_compile() {

	sed -i -e 's:$compiler -v\( 2>&1 | sed -e "/version/!d"\|\):$compiler -dumpversion:' sysinfo.sh || die

	sed -i -e 's:inpath="NNET.DAT":inpath="/usr/share/nbench/NNET.DAT":' nbench1.h || die

	make CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin nbench
	insinto /usr/share/nbench
	doins NNET.DAT

	dodoc Changes README* RESULT bdoc.txt
}
