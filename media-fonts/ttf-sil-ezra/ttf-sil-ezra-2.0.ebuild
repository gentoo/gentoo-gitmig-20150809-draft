# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/ttf-sil-ezra/ttf-sil-ezra-2.0.ebuild,v 1.1 2008/01/19 22:31:59 dirtyepic Exp $

inherit font

MY_P="EzrSIL${PV//./}.zip"

DESCRIPTION="Opentype font for Biblical Hebrew texts following the typeface and traditions of the Biblia Hebraica Stuttgartensia."
HOMEPAGE="http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&item_id=EzraSIL_Home"
LICENSE="SIL-freeware"	# non-free
#SRC_URI="mirror://gentoo/${MY_P}"
SRC_URI="ftp://ftp.sil.org/fonts/win/${MY_P}"
#SRC_URI="http://scripts.sil.org/cms/scripts/render_download.php?site_id=nrsi&format=file&media_id=${MY_P}&filename=${MY_P}"

DEPEND="app-arch/unzip"
RDEPEND=""

SLOT="0"
KEYWORDS="~amd64 arm ia64 ppc s390 sh sparc x86 ~x86-fbsd"
IUSE="X"

DOCS="Documentation/*"
FONT_SUFFIX="ttf"
S="${WORKDIR}/Ezra SIL Release 2.0"
FONT_S="${S}/Fonts"
