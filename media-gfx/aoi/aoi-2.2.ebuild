# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/aoi/aoi-2.2.ebuild,v 1.4 2006/10/05 14:45:49 gustavoz Exp $

inherit java-pkg eutils

MY_P="aoi22"
S="${WORKDIR}/ArtOfIllusion${PV}"
DESCRIPTION="A free, open-source 3D modelling and rendering studio."
SRC_URI="mirror://sourceforge/aoi/${MY_P}.zip
	doc? ( mirror://sourceforge/aoi/manual${PV}.zip )"
HOMEPAGE="http://aoi.sourceforge.net/index"
KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="GPL-2"
SLOT="0"
DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jdk-1.2"
IUSE="doc"

src_unpack() {
	cd "${WORKDIR}"
	unpack ${MY_P}.zip
	use doc && unpack manual${PV}.zip
}

src_install() {
	# wrapper script
	dobin "${FILESDIR}"/aoi

	# documentation
	dodoc HISTORY README
	if use doc ; then
		mv "${WORKDIR}"/AoI\ Manual/ "${WORKDIR}"/aoi_manual/
		dohtml -r "${WORKDIR}"/aoi_manual/
	fi

	# main app
	java-pkg_dojar ArtOfIllusion.jar

	# plugins
	mv Plugins "${D}"/usr/share/${PN}/lib

	# scripts
	mv Scripts "${D}"/usr/share/${PN}

	# icon
	mv Icons/64x64.png Icons/aoi.png
	doicon Icons/aoi.png
}
