# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/agistudio/agistudio-1.2.2.ebuild,v 1.2 2007/02/13 23:42:25 mr_bones_ Exp $

inherit toolchain-funcs qt3

DESCRIPTION="QT AGI Studio allows you to view, create and edit AGI games"
HOMEPAGE="http://agistudio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="$(qt_min_version 3.3)"

S=${WORKDIR}/${P}/src

src_unpack() {
	unpack "${A}"
	cd "${S}"
	sed -i \
		-e "s#^QTDIR.*#QTDIR = ${QTDIR}#" \
		-e "s#^INCPATH.*#INCPATH = -I\$(QTDIR)/include#" \
		-e "s/g++/$(tc-getCXX)/" \
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
