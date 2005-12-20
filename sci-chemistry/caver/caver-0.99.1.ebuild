# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/caver/caver-0.99.1.ebuild,v 1.1 2005/12/20 03:56:38 spyderous Exp $

inherit multilib python

MY_PN="${PN}_unix"
MY_P="${MY_PN}_v${PV}"
DESCRIPTION="Rapid, accurate and fully automated calculation of pathways leading from buried cavities to outside solvent in static and dynamic protein structures"
HOMEPAGE="http://viper.chemi.muni.cz/caver/"
SRC_URI="${MY_P}.tar.gz
	pymol? ( pymolplug.tar.gz )"
LICENSE="CAVER"
SLOT="0"
KEYWORDS="~x86"
IUSE="pymol"
RDEPEND="media-libs/qhull
	pymol? ( sci-chemistry/pymol )"
DEPEND="${RDEPEND}"
RESTRICT="fetch"
S="${WORKDIR}/${MY_P}"

pkg_nofetch() {
	einfo "Download ${MY_P}.tar.gz"
	if use pymol; then
		einfo "and pymolplug.tar.gz"
	fi
	einfo "from ${HOMEPAGE}. This requires registration."
	einfo "Place them in ${DISTDIR}."
}

src_install() {
	make DESTDIR="${D}" install
	if use pymol; then
		python_version
		sed -i \
			-e "s:^\(CAVER_BINARY_LOCATION\).*:\1 = \"${ROOT}usr/bin/caver\":g" \
			${WORKDIR}/pymolplug/caver.py
		insinto /usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup
		doins ${WORKDIR}/pymolplug/caver.py
	fi
}

pkg_postinst() {
	if use pymol; then
		python_mod_compile \
		/usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/caver.py
	fi
}
