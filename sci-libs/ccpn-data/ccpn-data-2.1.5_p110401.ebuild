# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/ccpn-data/ccpn-data-2.1.5_p110401.ebuild,v 1.1 2011/04/01 10:29:45 jlec Exp $

EAPI="3"

inherit portability versionator

PATCHSET="${PV##*_p}"
MY_PN="${PN/-data}mr"
MY_PV="$(replace_version_separator 3 _ ${PV%%_p*})"
MY_MAJOR="$(get_version_component_range 1-3)"

DESCRIPTION="The Collaborative Computing Project for NMR - Data"
HOMEPAGE="http://www.ccpn.ac.uk/ccpn"
SRC_URI="http://www.bio.cam.ac.uk/ccpn/download/${MY_PN}/analysis${MY_PV}.tar.gz"
[[ -n ${PATCHSET} ]] && SRC_URI+=" http://dev.gentoo.org/~jlec/distfiles/ccpn-update-${MY_MAJOR}-${PATCHSET}.patch.bz2"

SLOT="0"
LICENSE="|| ( CCPN LGPL-2.1 )"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="!<sci-chemistry/ccpn-${PV}"
DEPEND=""

RESTRICT="binchecks strip"

S="${WORKDIR}"/ccpnmr/ccpnmr2.1

src_prepare() {
	[[ -n ${PATCHSET} ]] && \
		epatch "${WORKDIR}"/ccpn-update-${MY_MAJOR}-${PATCHSET}.patch
}

src_install() {
	dodir /usr/share/doc/${PF}/html
	sed \
		-e "s:../ccpnmr2.1:${EPREFIX}/usr/share/doc/${PF}/html:g" \
		../doc/index.html > "${ED}"/usr/share/doc/${PF}/html/index.html || die
	treecopy $(find python/ -name doc -type d) "${ED}"/usr/share/doc/${PF}/html/
	dohtml -r doc/* || die
	insinto /usr/share/ccpn
	doins -r data model || die
}
