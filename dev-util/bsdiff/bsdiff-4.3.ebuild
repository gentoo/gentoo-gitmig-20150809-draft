# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bsdiff/bsdiff-4.3.ebuild,v 1.1 2005/09/17 07:47:38 ferringb Exp $

inherit toolchain-funcs

IUSE=""

DESCRIPTION="bsdiff: Binary Differencer using a suffix alg"
HOMEPAGE="http://www.daemonology.net/bsdiff/"
SRC_URI="http://www.daemonology.net/bsdiff/${P}.tar.gz"

SLOT="0"
LICENSE="BSD-protection"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ia64"

DEPEND="app-arch/bzip2"

src_compile() {
	local BZIP
	BZIP=$(type -p bzip2)
	cd ${S}
	$(tc-getCC) -o bsdiff -DBZIP2=\"${BZIP}\" bsdiff.c -lbz2 || die "failed compiling bsdiff"
	$(tc-getCC) -o bspatch -DBZIP2=\"${BZIP}\" bspatch.c -lbz2 || die "failed compiling bspatch"
}

src_install() {
	insinto /usr
	dobin ${S}/bs{diff,patch}
	doman ${S}/bs{diff,patch}.1
}
