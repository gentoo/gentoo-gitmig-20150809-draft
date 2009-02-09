# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/aoi/aoi-2.2.1.ebuild,v 1.4 2009/02/09 19:49:56 maekke Exp $

inherit java-pkg-2 eutils

MY_P="aoi221"
MY_MANUAL_V="2.2"
S="${WORKDIR}/ArtOfIllusion${PV}"
DESCRIPTION="A free, open-source 3D modelling and rendering studio."
SRC_URI="mirror://sourceforge/aoi/${MY_P}.zip
	doc? ( mirror://sourceforge/aoi/manual${MY_MANUAL_V}.zip )"
HOMEPAGE="http://aoi.sourceforge.net/index"
KEYWORDS="~amd64 ~ppc x86"
LICENSE="GPL-2"
SLOT="0"
DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jre-1.4"
IUSE="doc"

src_install() {
	# documentation
	dodoc HISTORY README
	if use doc ; then
		mv "${WORKDIR}"/AoI\ Manual/ "${WORKDIR}"/aoi_manual
		dohtml -r "${WORKDIR}"/aoi_manual/
	fi

	# main app
	java-pkg_dojar ArtOfIllusion.jar

	# run script
	java-pkg_dolauncher aoi \
		--jar ArtOfIllusion.jar \
		--java_args -Xmx128M

	# plugins
	mv Plugins "${D}"/usr/share/${PN}/lib

	# scripts
	mv Scripts "${D}"/usr/share/${PN}/lib

	# icon
	mv Icons/64x64.png Icons/aoi.png
	doicon Icons/aoi.png

	# desktop entry
	make_desktop_entry aoi "Art of Illusion" /usr/share/pixmaps/aoi.png "Graphics"
}
