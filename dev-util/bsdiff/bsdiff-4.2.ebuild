# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bsdiff/bsdiff-4.2.ebuild,v 1.5 2005/04/01 05:24:56 agriffis Exp $

IUSE=""

DESCRIPTION="bsdiff: Binary Differencer using a suffix alg"
HOMEPAGE="http://www.daemonology.net/bsdiff/"
SRC_URI="http://www.daemonology.net/bsdiff/${P}.tar.gz"

SLOT="0"
LICENSE="BSD-protection"
KEYWORDS="x86 ~ppc sparc alpha ~hppa ~mips ~amd64 ia64"

DEPEND="app-arch/bzip2"

src_compile() {
	BZIP=`which bzip2`
	cd ${S}
	gcc bsdiff.c -o bsdiff -DBZIP2=\"${BZIP}\"
	gcc bspatch.c -o bspatch -DBZIP2=\"${BZIP}\"
}

src_install() {
	insinto /usr
	dobin ${S}/bs{diff,patch}
	doman ${S}/bs{diff,patch}.1
}
