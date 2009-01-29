# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/zhu3d/zhu3d-4.1.8.ebuild,v 1.1 2009/01/29 11:17:40 bicatali Exp $

EAPI=2

inherit eutils qt4

DESCRIPTION="Interactive 3D mathematical function viewer"
HOMEPAGE="http://sourceforge.net/projects/zhu3d"
LICENSE="GPL-2"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

IUSE=""

KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="|| ( ( x11-libs/qt-gui:4 x11-libs/qt-opengl:4 )
		x11-libs/qt:4[opengl] )
	virtual/glu"
DEPEND="${RDEPEND}"

src_prepare() {
	local datadir=/usr/share/${PN}
	sed -i \
		-e "s:^SYSDIR=:SYSDIR=${datadir}/system:" \
		-e "s:^TEXDIR=:TEXDIR=${datadir}/textures:" \
		-e "s:^WORKDIR=:WORKDIR=${datadir}/work:" \
		-e "s:^DOCDIR=:WORKDIR=/usr/share/doc/${PF}/html:" \
		${PN}.pri || die "sed zhu3d.pri failed"
}

src_configure() {
	eqmake4
}

src_install() {
	# not working: emake install INSTALL_ROOT="${D}" || die
	dobin zhu3d || die

	dodoc {readme,src/changelog}.txt || die
	dohtml doc/* || die

	insinto /usr/share/${PN}
	rm -f system/languages/*.ts
	doins -r work system || die

	doicon system/icons/${PN}.png || die
	make_desktop_entry ${PN} Zhu3D ${PN} "Education;Science;Math;Qt"
}
