# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/last/last-128.ebuild,v 1.1 2010/07/15 15:49:58 weaver Exp $

EAPI="2"

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
	sed -i -e 's/CXXFLAGS =/CXXFLAGS +=/' -e 's/CCFLAGS =/CCFLAGS = ${CFLAGS}/' \
		src/makefile || die
}

src_compile() {
	emake -C src || die
}

src_install() {
	dobin src/last{al,db} || die
	exeinto /usr/share/${PN}/scripts
	doexe scripts/* || die
	insinto /usr/share/doc/${PF}
	doins -r doc ChangeLog.txt README.txt
}
