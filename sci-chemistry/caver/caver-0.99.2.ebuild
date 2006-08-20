# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/caver/caver-0.99.2.ebuild,v 1.2 2006/08/20 23:00:56 dberkholz Exp $

inherit multilib python

MY_PN="${PN}_unix"
MY_P="${MY_PN}_v${PV}"
PLUG_P="${MY_P/caver/caverPLUG}"
DESCRIPTION="Rapid, accurate and fully automated calculation of pathways leading from buried cavities to outside solvent in static and dynamic protein structures"
HOMEPAGE="http://viper.chemi.muni.cz/caver/"
SRC_URI="${MY_P}.tar.gz
	pymol? ( ${PLUG_P}.tar.gz )"
LICENSE="CAVER"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="pymol"
RDEPEND="media-libs/qhull
	pymol? ( sci-chemistry/pymol )"
DEPEND="${RDEPEND}"
RESTRICT="fetch"
S="${WORKDIR}/${MY_P}"

pkg_nofetch() {
	einfo "Download ${MY_P}.tar.gz"
	if use pymol; then
		einfo "and ${PLUG_P}.tar.gz"
	fi
	einfo "from ${HOMEPAGE}. This requires registration."
	einfo "Place tarballs in ${DISTDIR}."
}

src_install() {
	make DESTDIR="${D}" install
	if use pymol; then
		python_version
		sed -i \
			-e "s:^\(CAVER_BINARY_LOCATION\).*:\1 = \"${ROOT}usr/bin/caver\":g" \
			${WORKDIR}/${PLUG_P}/caver.py
		insinto /usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup
		doins ${WORKDIR}/${PLUG_P}/caver.py
	fi
}

pkg_postinst() {
	if use pymol; then
		python_mod_compile \
		/usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/caver.py
	fi
}
