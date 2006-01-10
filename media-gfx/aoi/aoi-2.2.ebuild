# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/aoi/aoi-2.2.ebuild,v 1.1 2006/01/10 00:11:39 vanquirius Exp $

inherit java-pkg eutils

MY_P="aoi22"
S="${WORKDIR}/ArtOfIllusion${PV}"
DESCRIPTION="A free, open-source 3D modelling and rendering studio."
SRC_URI="mirror://sourceforge/aoi/${MY_P}.zip
	doc? ( mirror://sourceforge/aoi/manual${PV}.zip )"
HOMEPAGE="http://aoi.sourceforge.net/index"
KEYWORDS="~x86 ~sparc ~ppc"
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

	# plugins and scripts
	dodir /usr/share/${PN}/lib
	mv Plugins "${D}"/usr/share/${PN}/lib
	mv Scripts "${D}"/usr/share/${PN}

	# main app
	mv ArtOfIllusion.jar "${D}"/usr/share/${PN}/lib

	# icon
	mv Icons/64x64.png Icons/aoi.png
	doicon Icons/aoi.png
}
