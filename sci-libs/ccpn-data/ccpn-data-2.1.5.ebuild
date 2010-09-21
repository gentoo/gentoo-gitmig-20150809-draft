# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/ccpn-data/ccpn-data-2.1.5.ebuild,v 1.1 2010/09/21 13:09:42 jlec Exp $

EAPI="3"

inherit portability versionator

MY_PN="${PN}mr"
MY_PV="$(replace_version_separator 3 _ ${PV%%_p*})"

DESCRIPTION="The Collaborative Computing Project for NMR - Data"
HOMEPAGE="http://www.ccpn.ac.uk/ccpn"
SRC_URI="http://www.bio.cam.ac.uk/ccpn/download/${MY_PN}/analysis${MY_PV}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="CCPN"
IUSE=""

RDEPEND="!<sci-chemistry/ccpn-${PV}"
DEPEND=""

RESTRICT="binchecks strip"
S="${WORKDIR}"/ccpnmr/ccpnmr2.1

src_install() {
	dodir "${EPREFIX}"/usr/share/doc/${PF}/html
	sed \
		-e "s:../ccpnmr2.1:${EPREFIX}/usr/share/doc/${PF}/html:g" \
		../doc/index.html > "${ED}"/usr/share/doc/${PF}/html/index.html || die
	treecopy $(find python/ -name doc -type d) "${ED}"/usr/share/doc/${PF}/html/
	dohtml -r doc/* || die
	insinto /usr/share/ccpn
	doins -r data model || die
}
