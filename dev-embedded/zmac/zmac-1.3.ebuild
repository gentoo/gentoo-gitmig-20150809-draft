# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/zmac/zmac-1.3.ebuild,v 1.3 2008/01/11 21:20:57 ulm Exp $

inherit toolchain-funcs versionator

MY_PV=$(delete_all_version_separators)
DESCRIPTION="Z80 macro cross-assembler"
HOMEPAGE="http://www.tim-mann.org/trs80resources.html"
SRC_URI="http://www.tim-mann.org/trs80/${PN}${MY_PV}.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin zmac
	doman zmac.1
	dodoc ChangeLog MAXAM NEWS README || die "dodoc failed"
}
