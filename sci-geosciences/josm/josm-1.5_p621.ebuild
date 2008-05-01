# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/josm/josm-1.5_p621.ebuild,v 1.1 2008/05/01 19:59:52 hanno Exp $

inherit eutils

MY_P=${PN}-snapshot-${PV/1.5_p/}
DESCRIPTION="Java-based editor for the OpenStreetMap project"
HOMEPAGE="http://josm.openstreetmap.de/"
SRC_URI="http://josm.openstreetmap.de/download/${MY_P}.jar
	linguas_de? ( mirror://gentoo/lang-de-20080321.jar )
	linguas_en_GB? ( mirror://gentoo/lang-en_GB-20080207.jar )
	linguas_fr? ( mirror://gentoo/lang-fr-20080207.jar )
	linguas_ro? ( mirror://gentoo/lang-ro-20080207.jar )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="virtual/jdk"
S="${WORKDIR}"

LINGUAS="en de"
IUSE="linguas_de linguas_en_GB linguas_fr linguas_ro"

src_unpack() {
	einfo Nothing to unpack
}

src_compile() {
	einfo Nothing to compile
}

src_install() {
	dobin "${FILESDIR}/josm" || die

	insinto /usr/lib/josm/
	newins "${DISTDIR}/${MY_P}.jar" josm.jar || die

	insinto /usr/lib/josm/plugins
	use linguas_de && newins "${DISTDIR}/lang-de-20080321.jar" lang-de.jar
	use linguas_en_GB && newins "${DISTDIR}/lang-en_GB-20080207.jar" lang-en_GB.jar
	use linguas_fr && newins "${DISTDIR}/lang-fr-20080207.jar" lang-fr.jar
	use linguas_ro && newins "${DISTDIR}/lang-ro-20080207.jar" lang-ro.jar

	doicon "${FILESDIR}/josm.png" || die
	make_desktop_entry "${PN}" "Java OpenStreetMap Editor" josm "Application"
}
