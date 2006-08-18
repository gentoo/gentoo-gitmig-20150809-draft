# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/caver/caver-0.99.4.ebuild,v 1.1 2006/08/18 16:48:41 ribosome Exp $

inherit multilib python eutils

MY_PN="${PN}_unix"
MY_P="${MY_PN}_v${PV}"
PLUG_P="${MY_P/caver/caverPLUG}"

DESCRIPTION="Rapid, accurate and fully automated calculation of pathways leading from buried cavities to outside solvent in static and dynamic protein structures"
HOMEPAGE="http://viper.chemi.muni.cz/caver/"
SRC_URI="${MY_P}.tar.gz
	pymol? ( ${PLUG_P}.tar.gz )"
LICENSE="CAVER"

SLOT="0"
KEYWORDS="~ppc ~x86"
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

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-001.patch
}

src_install() {
	make DESTDIR="${D}" install
	doman man/man1/* || die "Failed to install man page."
	if use pymol; then
		python_version
		sed -e "s:^\(CAVER_BINARY_LOCATION\).*:\1 = \"${ROOT}usr/bin/caver\":g" \
				-i "${WORKDIR}"/${PLUG_P}/caver.py \
				|| die "Failed setting caver location"
		insinto /usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup
		doins "${WORKDIR}"/${PLUG_P}/caver.py || die "Failed to install plugin"
	fi
	cd "${S}"/pdb2caver
	dobin pdb2caver || die "Failed to install pdb2caver"
	newdoc README README_pdb2caver || die "Failed to install pdb2caver readme."
}

pkg_postinst() {
	if use pymol; then
		python_mod_compile \
		/usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/caver.py
	fi
}
