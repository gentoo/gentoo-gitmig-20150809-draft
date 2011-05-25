# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/sil-charis/sil-charis-4.106.ebuild,v 1.7 2011/05/25 16:48:57 flameeyes Exp $

EAPI=2

inherit font

MY_PN="CharisSIL"

DESCRIPTION="SIL Charis - SIL fonts for Roman and Cyrillic languages"
HOMEPAGE="http://scripts.sil.org/CharisSILfont"
SRC_URI="http://scripts.sil.org/cms/scripts/render_download.php?site_id=nrsi&format=file&media_id=CharisSIL4.106b.zip&filename=CharisSIL4.106.zip -> CharisSIL4.106.zip
	compact? ( http://scripts.sil.org/cms/scripts/render_download.php?site_id=nrsi&format=file&media_id=CharisSILCompact4.106.zip&filename=CharisSILCompact4.106.zip -> CharisSILCompact4.106.zip )"

LICENSE="OFL"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="doc +compact"

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/${MY_PN}"
FONT_S="${S}"
FONT_SUFFIX="ttf"
DOCS="OFL-FAQ.txt"

src_unpack() {
	unpack ${A}
	if use compact; then
		mv "${MY_PN}Compact/"*.ttf "${MY_PN}" || die "mv ${WORKDIR}/${MY_PN}Compact/*.ttf ${WORKDIR}/${MY_PN} failed"
	fi
}

src_install() {
	font_src_install
	use doc && dodoc *.pdf
}
