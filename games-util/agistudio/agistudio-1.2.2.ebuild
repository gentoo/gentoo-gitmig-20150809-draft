# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/agistudio/agistudio-1.2.2.ebuild,v 1.7 2009/08/09 19:13:24 ssuominen Exp $

EAPI=1

inherit eutils toolchain-funcs qt3

DESCRIPTION="QT AGI Studio allows you to view, create and edit AGI games"
HOMEPAGE="http://agistudio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="x11-libs/qt:3"

S=${WORKDIR}/${P}/src

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-glibc-2.10.patch
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
