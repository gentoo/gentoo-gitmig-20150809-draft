# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/erza-sil/erza-sil-2.0.ebuild,v 1.1 2004/10/03 13:04:08 usata Exp $

inherit font

MY_P="EzrSIL${PV//./}.zip"

DESCRIPTION="Opentype font for Biblical Hebrew texts following the typeface and traditions of the Biblia Hebraica Stuttgartensia."
HOMEPAGE="http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&item_id=EzraSIL_Home"
LICENSE="SIL-freeware"	# non-free
#SRC_URI="mirror://gentoo/${MY_P}"
SRC_URI="ftp://ftp.sil.org/fonts/win/${MY_P}"
#SRC_URI="http://scripts.sil.org/cms/scripts/render_download.php?site_id=nrsi&format=file&media_id=${MY_P}&filename=${MY_P}"

SLOT="0"
KEYWORDS="~x86"
IUSE="X"

DOCS="Documentation/*"
FONT_SUFFIX="ttf"
S="${WORKDIR}/Ezra SIL Release 2.0"
FONT_S="${S}/Fonts"

