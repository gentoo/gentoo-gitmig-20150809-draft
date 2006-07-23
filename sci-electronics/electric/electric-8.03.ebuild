# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/electric/electric-8.03.ebuild,v 1.1 2006/07/23 15:07:20 calchan Exp $

inherit eutils

DESCRIPTION="Complete Electronic Design Automation (EDA) system that can handle many forms of circuit design"
HOMEPAGE="http://www.gnu.org/software/electric/electric.html"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/electric/${PN}Binary-${PV}.jar"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=virtual/jre-1.3"

S="${WORKDIR}"

src_install() {
	dojar ${DISTDIR}/${PN}Binary-${PV}.jar
	newicon com/sun/electric/tool/user/help/helphtml/iconplug.png electric.png
	make_wrapper electric "java -jar /usr/share/electric/lib/${PN}Binary-${PV}.jar"
	make_desktop_entry electric "Electric VLSI Design System" electric.png Electronics
}
