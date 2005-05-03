# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/mathematica-fonts/mathematica-fonts-4.2.ebuild,v 1.2 2005/05/03 20:32:56 mr_bones_ Exp $

inherit font

DESCRIPTION="Mathematica's Fonts for MathML"

HOMEPAGE="http://support.wolfram.com/mathematica/systems/windows/general/latestfonts.html"
DOWNLOAD_URI="http://support.wolfram.com/mathematica/systems/windows/general/"
TRUETYPE_FILE="MathFonts_TrueType_${PV//./}.exe"
TYPE1_FILE="MathFonts_Type1_${PV//./}.exe"

SRC_URI="truetype? ( $TRUETYPE_FILE )
!truetype? ( $TYPE1_FILE )"
LICENSE="WRI-EULA"

SLOT="0"
KEYWORDS="~x86"
IUSE="truetype"
DEPEND="app-arch/unzip"
RDEPEND=""
RESTRICT="fetch nomirror"
S=${WORKDIR}/
FONT_S=${S}

pkg_nofetch() {
	einfo "Please visit the homepage:"
	einfo "$HOMEPAGE"
	einfo "and download "
	if use truetype; then
		einfo ${DOWNLOAD_URI}${TRUETYPE_FILE}
	else
		einfo ${DOWNLOAD_URI}${TYPE1_FILE}
	fi
	einfo "Then just put the file in ${DISTDIR}"
}

src_unpack() {
	# zip is sufficient to extract the archive
	unzip ${DISTDIR}/${A} >/dev/null || die "failed to unpack ${A}"
}

src_install() {
	if use truetype; then
		FONT_SUFFIX="ttf"
	else
		FONT_SUFFIX="pf*"
	fi

	font_src_install
}
