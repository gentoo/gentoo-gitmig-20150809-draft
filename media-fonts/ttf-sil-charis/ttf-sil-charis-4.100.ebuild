# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/ttf-sil-charis/ttf-sil-charis-4.100.ebuild,v 1.4 2008/01/16 07:57:55 opfer Exp $

inherit font versionator

MY_PN="CharisSIL"

DESCRIPTION="Charis Typeface"
HOMEPAGE="http://scripts.sil.org/CharisSILfont"
SRC_URI="mirror://gentoo/${MY_PN}${PV}.zip"

LICENSE="OFL"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE="X doc"

DEPEND="${DEPEND}
		app-arch/unzip"

S="${WORKDIR}"
FONT_S="${S}"
FONT_SUFFIX="ttf"
DOCS="*.txt"

src_install() {
	font_src_install
	if use doc ; then
		insinto /usr/share/doc/${PN}-${PVR}
		doins *.pdf
	fi
}
