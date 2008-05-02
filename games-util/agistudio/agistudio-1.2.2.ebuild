# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/agistudio/agistudio-1.2.2.ebuild,v 1.5 2008/05/02 22:14:08 nyhm Exp $

inherit eutils toolchain-funcs qt3

DESCRIPTION="QT AGI Studio allows you to view, create and edit AGI games"
HOMEPAGE="http://agistudio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="$(qt_min_version 3.3)"

S=${WORKDIR}/${P}/src

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
	sed -i \
		-e "s#^QTDIR.*#QTDIR = ${QTDIR}#" \
		-e "s#^INCPATH.*#INCPATH = -I\$(QTDIR)/include#" \
		-e "s:g++:$(tc-getCXX):" \
		-e "/^CXXFLAGS/s:-O2:${CXXFLAGS}:" \
		-e 's/$(LFLAGS)/$(LDFLAGS)/' \
		Makefile \
		|| die "sed failed"
}

src_install() {
	dobin agistudio || die "dobin failed"
	cd ..
	insinto /usr/share/${PN}
	doins -r help template || die "doins failed"
	doman agistudio.1
	dodoc README relnotes
}
