# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/ezra-sil/ezra-sil-2.5.ebuild,v 1.5 2007/08/24 23:00:17 philantrop Exp $

inherit font

MY_P="EzraSIL${PV//./}.zip"

DESCRIPTION="Opentype font for Biblical Hebrew texts following the typeface and traditions of the Biblia Hebraica Stuttgartensia."
HOMEPAGE="http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&item_id=EzraSIL_Home"
LICENSE="MIT OFL-1.1"

# We need to mirror the distfile as the download url is a bunch of php garbage
SRC_URI="mirror://gentoo/${MY_P}"
#SRC_URI="ftp://ftp.sil.org/fonts/win/${MY_P}"
#SRC_URI="http://scripts.sil.org/cms/scripts/render_download.php?site_id=nrsi&format=file&media_id=${MY_P}&filename=${MY_P}"

DEPEND="app-arch/unzip"
RDEPEND=""

SLOT="0"
KEYWORDS="amd64 ~arm ia64 ~ppc ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE=""

DOCS="README.txt"
FONT_SUFFIX="ttf"
S="${WORKDIR}"
FONT_S="${S}"
