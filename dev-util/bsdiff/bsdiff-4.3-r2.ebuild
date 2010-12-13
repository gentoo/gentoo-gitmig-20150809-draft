# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bsdiff/bsdiff-4.3-r2.ebuild,v 1.1 2010/12/13 00:35:03 flameeyes Exp $

EAPI=2

inherit toolchain-funcs flag-o-matic

IUSE=""

DESCRIPTION="bsdiff: Binary Differencer using a suffix alg"
HOMEPAGE="http://www.daemonology.net/bsdiff/"
SRC_URI="http://www.daemonology.net/bsdiff/${P}.tar.gz"

SLOT="0"
LICENSE="BSD-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos"

DEPEND="app-arch/bzip2"
RDEPEND="${DEPEND}"

doecho() {
		echo "$@"
		"$@"
}

src_compile() {
	append-lfs-flags
	doecho $(tc-getCC) ${CPPFLAGS} ${CFLAGS} ${LDFLAGS} -o bsdiff bsdiff.c -lbz2 || die "failed compiling bsdiff"
	doecho $(tc-getCC) ${CPPFLAGS} ${CFLAGS} ${LDFLAGS} -o bspatch bspatch.c -lbz2 || die "failed compiling bspatch"
}

src_install() {
	dobin bs{diff,patch} || die
	doman bs{diff,patch}.1 || die
}
