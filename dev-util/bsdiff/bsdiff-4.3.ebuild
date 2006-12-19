# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bsdiff/bsdiff-4.3.ebuild,v 1.5 2006/12/19 13:13:38 eroyf Exp $

inherit toolchain-funcs

IUSE=""

DESCRIPTION="bsdiff: Binary Differencer using a suffix alg"
HOMEPAGE="http://www.daemonology.net/bsdiff/"
SRC_URI="http://www.daemonology.net/bsdiff/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="alpha amd64 ~hppa ia64 mips ppc sparc x86 ~x86-fbsd"

DEPEND="app-arch/bzip2"

src_compile() {
	cd ${S}
	$(tc-getCC) -o bsdiff bsdiff.c -lbz2 || die "failed compiling bsdiff"
	$(tc-getCC) -o bspatch bspatch.c -lbz2 || die "failed compiling bspatch"
}

src_install() {
	insinto /usr
	dobin ${S}/bs{diff,patch}
	doman ${S}/bs{diff,patch}.1
}
