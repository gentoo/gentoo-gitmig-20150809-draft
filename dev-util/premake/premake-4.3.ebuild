# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/premake/premake-4.3.ebuild,v 1.5 2012/02/22 12:14:03 titanofold Exp $

EAPI="4"

inherit eutils

DESCRIPTION="A makefile generation tool"
HOMEPAGE="http://industriousone.com/premake"
SRC_URI="mirror://sourceforge/premake/${P}-src.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}/archless.patch"
}

src_compile() {
	cd "${S}/build/gmake.unix/"
	emake
}

src_install() {
	dobin bin/release/premake4
}
