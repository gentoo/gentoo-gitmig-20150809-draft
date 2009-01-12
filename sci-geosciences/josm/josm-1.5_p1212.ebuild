# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/josm/josm-1.5_p1212.ebuild,v 1.1 2009/01/12 16:12:30 hanno Exp $

inherit eutils java-pkg-2

MY_P=${PN}-snapshot-${PV/1.5_p/}
DESCRIPTION="Java-based editor for the OpenStreetMap project"
HOMEPAGE="http://josm.openstreetmap.de/"
SRC_URI="http://josm.openstreetmap.de/download/${MY_P}.jar"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND=">=virtual/jre-1.6"
S="${WORKDIR}"

IUSE=""

src_install() {
	java-pkg_newjar "${DISTDIR}/${MY_P}.jar"

	# Using the eclass doesn't let us support the http_proxy var,
	# so we're using our own startscript for now.
	#java-pkg_dolauncher "${PN}" --jar "${PN}.jar"
	newbin "${FILESDIR}/${PN}-r1" "${PN}" || die "dobin failed"

	doicon "${FILESDIR}/josm.png" || die "doicon failed"
	make_desktop_entry "${PN}" "Java OpenStreetMap Editor" josm "Application"
}
