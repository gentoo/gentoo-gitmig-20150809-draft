# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tomsfastmath/tomsfastmath-0.03.ebuild,v 1.2 2006/03/19 22:34:45 halcy0n Exp $

DESCRIPTION="portable fixed precision math library geared towards doing one thing very fast"
HOMEPAGE="http://libtomcrypt.org/tfm/"
SRC_URI="http://libtomcrypt.org/tfm/files/tfm-${PV}.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="app-arch/unzip"
RDEPEND=""

src_install() {
	dolib.a libtfm.a || die "dolib.a"
	insinto /usr/include
	doins tfm.h || die "doinc"
	dodoc changes.txt doc/*.pdf
	docinto demo ; dodoc demo/*
}
