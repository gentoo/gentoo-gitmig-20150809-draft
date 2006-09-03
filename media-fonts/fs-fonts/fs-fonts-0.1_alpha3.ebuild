# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/fs-fonts/fs-fonts-0.1_alpha3.ebuild,v 1.6 2006/09/03 06:37:40 vapier Exp $

inherit font

IUSE=""
MY_P="${P/_alpha/test}"

DESCRIPTION="Japanese TrueType fonts designed for screen and print"
HOMEPAGE="http://x-tt.sourceforge.jp/fs_fonts/"
SRC_URI="mirror://sourceforge.jp/x-tt/7862/${MY_P}.tar.gz"

KEYWORDS="~amd64 arm ~hppa ia64 ~ppc-macos s390 sh ~x86"
LICENSE="public-domain"
SLOT=0

S="${WORKDIR}"
FONT_S="${S}"
FONT_SUFFIX="ttf"
DOCS="AUTHORS *.txt THANKS Changes docs/README"

src_install() {
	font_src_install

	cd docs
	for d in kappa20 k14goth mplus_bitmap_fonts shinonome* Oradano kochi-substitute; do
		docinto $d
		dodoc $d/*
	done
}
