# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/josm/josm-1.5_p1041.ebuild,v 1.1 2008/10/15 13:27:53 hanno Exp $

inherit eutils java-pkg-2

MY_P=${PN}-snapshot-${PV/1.5_p/}
DESCRIPTION="Java-based editor for the OpenStreetMap project"
HOMEPAGE="http://josm.openstreetmap.de/"
SRC_URI="http://josm.openstreetmap.de/download/${MY_P}.jar
	linguas_de? ( mirror://gentoo/lang-de-20080705.jar )
	linguas_en_GB? ( mirror://gentoo/lang-en_GB-20080207.jar )
	linguas_fr? ( mirror://gentoo/lang-fr-20080207.jar )
	linguas_ro? ( mirror://gentoo/lang-ro-20080207.jar )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND=">=virtual/jre-1.6"
S="${WORKDIR}"

LINGUAS="en de"
IUSE="linguas_de linguas_en_GB linguas_fr linguas_ro"

src_install() {
	java-pkg_newjar "${DISTDIR}/${MY_P}.jar"

	# Using the eclass doesn't let us support the http_proxy var,
	# so we're using our own startscript for now.
	#java-pkg_dolauncher "${PN}" --jar "${PN}.jar"
	newbin "${FILESDIR}/${PN}-r1" "${PN}" || die "dobin failed"

	insinto /usr/share/josm/plugins
	use linguas_de && newins "${DISTDIR}/lang-de-20080705.jar" lang-de.jar
	use linguas_en_GB && newins "${DISTDIR}/lang-en_GB-20080207.jar" lang-en_GB.jar
	use linguas_fr && newins "${DISTDIR}/lang-fr-20080207.jar" lang-fr.jar
	use linguas_ro && newins "${DISTDIR}/lang-ro-20080207.jar" lang-ro.jar

	doicon "${FILESDIR}/josm.png" || die "doicon failed"
	make_desktop_entry "${PN}" "Java OpenStreetMap Editor" josm "Application"
}
