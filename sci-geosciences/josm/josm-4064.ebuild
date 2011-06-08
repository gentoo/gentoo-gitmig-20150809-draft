# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/josm/josm-4064.ebuild,v 1.1 2011/06/08 11:40:49 scarabeus Exp $

EAPI=4

JAVA_ANT_ENCODING=UTF-8

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Java-based editor for the OpenStreetMap project"
HOMEPAGE="http://josm.openstreetmap.de/"
SRC_URI="http://josm.fabian-fingerle.de/${P}.tar.xz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"

DEPEND=">=virtual/jdk-1.6"
RDEPEND=">=virtual/jre-1.6"

S="${WORKDIR}/${PN}"

IUSE=""

src_compile() {
	eant dist
}

src_install() {
	java-pkg_newjar "dist/${PN}.jar" || die "java-pkg_newjar failed"
	java-pkg_dolauncher "${PN}" --jar "${PN}.jar" || die "java-pkg_dolauncher failed"

	newicon images/logo.png josm.png || die "newicon failed"
	make_desktop_entry "${PN}" "Java OpenStreetMap Editor" josm "Science;Geoscience"
}
