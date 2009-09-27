# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/sil-doulos/sil-doulos-4.104.ebuild,v 1.6 2009/09/27 10:05:44 volkmar Exp $

inherit font versionator

DESCRIPTION="SIL Doulos - SIL font for Roman and Cyrillic Languages"
HOMEPAGE="http://scripts.sil.org/DoulosSILfont"
SRC_URI="mirror://gentoo/DoulosSIL${PV}.zip"

LICENSE="OFL"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="doc"

DOCS="OFL-FAQ.txt"
FONT_SUFFIX="ttf"

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/DoulosSIL"
FONT_S="${S}"

src_install() {
	font_src_install
	use doc && dodoc *.pdf
}
