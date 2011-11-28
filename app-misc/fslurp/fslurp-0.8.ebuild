# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fslurp/fslurp-0.8.ebuild,v 1.1 2011/11/28 09:51:45 radhermit Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="Read and display data from Fronius IG and IG Plus inverters"
HOMEPAGE="http://fslurp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.7-makefile.patch
}

src_compile() {
	emake -f makefile CC="$(tc-getCC)"
}

src_install() {
	dobin ${PN}
	dodoc History README SampleOutput
}
