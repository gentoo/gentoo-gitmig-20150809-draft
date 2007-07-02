# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/fteqcc/fteqcc-2501.ebuild,v 1.3 2007/07/02 00:08:48 nyhm Exp $

inherit eutils

DESCRIPTION="QC compiler"
HOMEPAGE="http://fteqw.sourceforge.net/"
SRC_URI="mirror://sourceforge/fteqw/qclibsrc${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="test"

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-cleanup-source.patch
	sed -i \
		-e "s: -O3 : :g" \
		-e "s: -s : :g" \
		Makefile || die "sed failed"
	edos2unix readme.txt
}

src_compile() {
	emake BASE_CFLAGS="${CFLAGS} -Wall" || die "emake qcc failed"
}

src_install() {
	newbin fteqcc.bin fteqcc || die "newbin fteqcc.bin failed"
	dodoc readme.txt
}
