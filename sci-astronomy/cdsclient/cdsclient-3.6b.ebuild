# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/cdsclient/cdsclient-3.6b.ebuild,v 1.1 2011/09/23 17:35:12 xarthisius Exp $

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
	sed -i \
		-e 's/aclient.tex//' \
		"${S}"/configure || die
}
