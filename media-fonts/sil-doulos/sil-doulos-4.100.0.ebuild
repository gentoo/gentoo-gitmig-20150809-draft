# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/sil-doulos/sil-doulos-4.100.0.ebuild,v 1.1 2008/05/19 19:22:05 dirtyepic Exp $

inherit font versionator

DESCRIPTION="SIL Doulos - SIL font for Roman and Cyrillic Languages"
HOMEPAGE="http://scripts.sil.org/DoulosSILfont"
SRC_URI="mirror://gentoo/ttf-${P}.tgz"

LICENSE="OFL"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="doc"

DOCS="OFL-FAQ.txt"
FONT_SUFFIX="ttf"

S="${WORKDIR}/ttf-${P}"
FONT_S="${S}"

src_install() {
	font_src_install
	use doc && dodoc *.pdf
}
