# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/daa2iso/daa2iso-0.1.7e.ebuild,v 1.1 2010/12/24 13:05:55 hwoarang Exp $

EAPI="2"
inherit base toolchain-funcs

DESCRIPTION="Program for converting the DAA and GBI files to ISO"
HOMEPAGE="http://aluigi.org/mytoolz.htm"
SRC_URI="http://aluigi.org/mytoolz/${PN}.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/src"
PATCHES=( "${FILESDIR}"/${P}-buildsystem.patch )

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	emake PREFIX="${D}"/usr install || die "emake install failed"
}
