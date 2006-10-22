# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tomsfastmath/tomsfastmath-0.05.ebuild,v 1.4 2006/10/22 04:04:07 vapier Exp $

inherit eutils

DESCRIPTION="portable fixed precision math library geared towards doing one thing very fast"
HOMEPAGE="http://libtomcrypt.org/tfm/"
SRC_URI="http://libtomcrypt.org/tfm/files/tfm-${PV}.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 arm ppc x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-asm-relax-x86.patch #152043
}

src_compile() {
	emake IGNORE_SPEED=1 || die
}

src_install() {
	dolib.a libtfm.a || die "dolib.a"
	insinto /usr/include
	doins tfm.h || die "doinc"
	dodoc changes.txt doc/*.pdf
	docinto demo ; dodoc demo/*
}
