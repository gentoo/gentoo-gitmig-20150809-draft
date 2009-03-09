# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/phyml/phyml-2.4.5-r1.ebuild,v 1.1 2009/03/09 13:41:01 weaver Exp $

inherit toolchain-funcs

DESCRIPTION="Estimation of large phylogenies by maximum likelihood"
HOMEPAGE="http://atgc.lirmm.fr/phyml/"
SRC_URI="http://www.lirmm.fr/~guindon/${PN}_v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}_v${PV}"

src_unpack() {
	unpack ${A}
	sed -i -e 's/^hello !!!//' \
		-e 's/^CFLAGS =/#CFLAGS =/' \
		-e 's/^CC =/CC ='$(tc-getCC)'#/' \
		-e 's/-static//' "${S}/Makefile"
}

src_install() {
	dobin phyml
}
