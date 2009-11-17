# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/jsmath-extra-dark/jsmath-extra-dark-1.0.ebuild,v 1.1 2009/11/17 06:47:03 bicatali Exp $

inherit font

SRC_BASE="http://www.math.union.edu/~dpvc/jsMath/download/extra-fonts/"
SRC_URI="${SRC_BASE}/bbold10/25/jsMath-bbold10.ttf
		${SRC_BASE}/cmbsy10/25/jsMath-cmbsy10.ttf
		${SRC_BASE}/cmmib10/25/jsMath-cmmib10.ttf
		${SRC_BASE}/cmss10/25/jsMath-cmss10.ttf
		${SRC_BASE}/eufb10/25/jsMath-eufb10.ttf
		${SRC_BASE}/eufm10/25/jsMath-eufm10.ttf
		${SRC_BASE}/eurb10/25/jsMath-eurb10.ttf
		${SRC_BASE}/eurm10/25/jsMath-eurm10.ttf
		${SRC_BASE}/eusb10/25/jsMath-eusb10.ttf
		${SRC_BASE}/eusm10/25/jsMath-eusm10.ttf
		${SRC_BASE}/lasy10/25/jsMath-lasy10.ttf
		${SRC_BASE}/lasyb10/25/jsMath-lasyb10.ttf
		${SRC_BASE}/msam10/25/jsMath-msam10.ttf
		${SRC_BASE}/msbm10/25/jsMath-msbm10.ttf
		${SRC_BASE}/rsfs10/25/jsMath-rsfs10.ttf
		${SRC_BASE}/stmary10/25/jsMath-stmary10.ttf
		${SRC_BASE}/wasy10/25/jsMath-wasy10.ttf
		${SRC_BASE}/wasyb10/25/jsMath-wasyb10.ttf"

DESCRIPTION="Extra raster fonts for jsmath, dark version"
HOMEPAGE="http://www.math.union.edu/~dpvc/jsMath/download/extra-fonts/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="media-fonts/jsmath
	!media-fonts/jsmath-extra-light"

S="${WORKDIR}"
FONT_S="${S}"
FONT_SUFFIX="ttf"

src_unpack() {
	for FONT in ${A};
		do cp -a "${DISTDIR}"/${FONT} "${S}"
	done
}
