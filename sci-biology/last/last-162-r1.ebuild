# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/last/last-162-r1.ebuild,v 1.1 2011/04/08 06:29:27 jlec Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Genome-scale comparison of biological sequences"
HOMEPAGE="http://last.cbrc.jp/"
SRC_URI="http://last.cbrc.jp/archive/${P}.zip"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${PV}-ldflags.patch
}

src_compile() {
	emake -e -C src CXX="$(tc-getCXX)" \
		STRICT="${LDFLAGS}" || die
}

src_install() {
	dobin src/last{al,db,ex} || die
	exeinto /usr/share/${PN}/scripts
	doexe scripts/* || die
	dodoc doc/*.txt ChangeLog.txt README.txt || die
}
