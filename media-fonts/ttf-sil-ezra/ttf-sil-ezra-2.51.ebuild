# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/ttf-sil-ezra/ttf-sil-ezra-2.51.ebuild,v 1.3 2008/01/23 18:34:24 armin76 Exp $

inherit font

MY_P="EzraSIL${PV//./}"

DESCRIPTION="SIL Ezra - SIL fonts for Biblical Hebrew"
HOMEPAGE="http://scripts.sil.org/EzraSIL_Home"
SRC_URI="mirror://gentoo/${MY_P}.zip"

LICENSE="MIT OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc"

DEPEND="app-arch/unzip
		!media-fonts/ezra-sil"
RDEPEND=""

S="${WORKDIR}/EzraSIL${PV}"
FONT_S="${S}"
FONT_SUFFIX="ttf"
DOCS="FONTLOG.txt OFL-FAQ.txt README.txt"

src_install() {
	font_src_install
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins *.pdf
	fi
}
