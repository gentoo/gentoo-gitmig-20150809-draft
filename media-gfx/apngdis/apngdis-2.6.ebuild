# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/apngdis/apngdis-2.6.ebuild,v 1.1 2013/12/17 10:18:30 radhermit Exp $

EAPI="4"

inherit toolchain-funcs eutils

DESCRIPTION="extract PNG frames from an APNG"
HOMEPAGE="http://sourceforge.net/projects/apngdis/"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}-src.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
	epatch "${FILESDIR}"/${P}-gcc-4.3.patch

	tc-export CXX
}

src_install() {
	dobin ${PN}
	dodoc readme.txt
}
