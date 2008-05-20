# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/zhu3d/zhu3d-4.0.2.ebuild,v 1.2 2008/05/20 18:59:00 bicatali Exp $

EAPI=1

inherit eutils qt4

DESCRIPTION="Interactive 3D mathematical function viewer"
HOMEPAGE="http://sourceforge.net/projects/zhu3d"
LICENSE="GPL-2"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

IUSE=""

KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="|| ( >=x11-libs/qt-4.2:4
			  ( x11-libs/qt-gui:4 x11-libs/qt-opengl:4 ) )
		virtual/glu"
DEPEND="${RDEPEND}"

QT4_BUILT_WITH_USE_CHECK="opengl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	local datadir=/usr/share/${PN}
	sed -i \
		-e "s:^SYSDIR=:SYSDIR=${datadir}/system:" \
		-e "s:^TEXDIR=:TEXDIR=${datadir}/textures:" \
		-e "s:^WORKDIR=:WORKDIR=${datadir}/work:" \
		-e "s:^DOCDIR=:WORKDIR=/usr/share/doc/${PF}/html:" \
		${PN}.pri || die "sed zhu3d.pri failed"
}

src_compile() {
	eqmake4 || die "eqmake4 failed"
	emake || die "emake failed"
}

src_install() {
	# not working: emake install INSTALL_ROOT="${D}"
	dobin zhu3d || die

	dodoc {readme,src/changelog}.txt || die
	dohtml doc/* || die

	insinto /usr/share/${PN}
	doins -r work system || die

	doicon system/icons/${PN}.png || die
	make_desktop_entry ${PN} Zhu3D ${PN} \
		"Education;Science;Math;Qt"
}
