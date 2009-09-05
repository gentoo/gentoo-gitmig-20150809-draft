# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/tavrasm/tavrasm-1.22.ebuild,v 1.2 2009/09/05 22:24:37 maekke Exp $

inherit versionator

DESCRIPTION="Compiles code written for Atmels AVR DOS assembler"
HOMEPAGE="http://www.tavrasm.org/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="
	sys-devel/bison
	sys-devel/flex"

S="${WORKDIR}/${PN}.$(delete_all_version_separators ${PV})"

src_compile() {
	cd src

	# The Makefile of tavrasm is stupid, hence the -j1
	emake -j1 || die "Compilation failed"
}

src_install() {
	dobin src/tavrasm
	doman tavrasm.1
	dodoc README
}
