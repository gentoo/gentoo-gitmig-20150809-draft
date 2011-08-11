# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fslurp/fslurp-0.7.ebuild,v 1.1 2011/08/11 07:08:30 radhermit Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="Read and display data from Fronius IG and IG Plus inverters"
HOMEPAGE="http://fslurp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
}

src_compile() {
	emake -f makefile CC="$(tc-getCC)"
}

src_install() {
	dobin ${PN}
	dodoc History README SampleOutput
}
