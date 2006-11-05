# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/ttf-sil-padauk/ttf-sil-padauk-2.1.ebuild,v 1.3 2006/11/05 10:53:08 nixnut Exp $

inherit font versionator

#MY_P="${PN/-/-sil-}-$(delete_version_separator 2)"

DESCRIPTION="Padauk Typeface"
HOMEPAGE="http://scripts.sil.org/padauk"
#SRC_URI="http://scripts.sil.org/cms/scripts/render_download.php?site_id=nrsi\&format=file\&media_id=MH_Padauk_tarball\&filename=padauk_2_1.tar.gz"
SRC_URI="mirror://gentoo/${P}.tgz"
LICENSE="OFL"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64"
IUSE="X doc"

DOCS="FONTLOG OFL OFL-FAQ local.conf"
FONT_SUFFIX="ttf"

#S="${WORKDIR}/${MY_P}"
FONT_S="${S}"

src_install() {
	font_src_install
	if use doc ; then
		insinto /usr/share/doc/${PN}-${PVR}
		doins *.pdf
	fi
}
