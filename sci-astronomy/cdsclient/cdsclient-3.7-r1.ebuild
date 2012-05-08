# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/cdsclient/cdsclient-3.7-r1.ebuild,v 1.1 2012/05/08 20:38:29 xarthisius Exp $

EAPI=4

inherit eutils versionator

DESCRIPTION="Collection of scripts to access the CDS databases"
HOMEPAGE="http://cdsweb.u-strasbg.fr/doc/cdsclient.html"
SRC_URI="ftp://cdsarc.u-strasbg.fr/pub/sw/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="app-shells/tcsh"

S=${WORKDIR}/${PN}-$(get_version_component_range 1-2)

src_prepare() {
	epatch "${FILESDIR}"/${PN}-gentoo.diff
	# remove non standard "mantex" page
	sed -i -e 's/aclient.tex//'	"${S}"/configure || die

	cat <<-EOF > "${T}"/99${PN}
		PATH=/usr/share/${PN}
	EOF
}

src_install() {
	emake DESTDIR="${D}" SHSDIR=/usr/share/${PN} install
	doenvd "${T}"/99${PN}
}
