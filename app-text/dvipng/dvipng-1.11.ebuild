# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dvipng/dvipng-1.11.ebuild,v 1.11 2008/07/10 01:20:31 gentoofan23 Exp $

inherit eutils

DESCRIPTION="A program to translate a DVI (DeVice Independent) files into PNG (Portable Network Graphics) bitmaps"
HOMEPAGE="http://dvipng.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE="truetype test"

RDEPEND="media-libs/gd
	media-libs/libpng
	virtual/latex-base
	sys-libs/zlib
	truetype? ( >=media-libs/freetype-2.1.5 )"
DEPEND="${RDEPEND}
	virtual/texi2dvi
	test? ( dev-texlive/texlive-fontsrecommended )"

pkg_setup() {
	if ! built_with_use media-libs/gd jpeg png; then
		eerror "You must rebuild media-libs/gd with USE=\"jpeg png\""
		die "You must rebuild media-libs/gd with USE=\"jpeg png\""
	fi
}

src_compile() {
	export VARTEXFONTS="${T}/fonts"
	econf $(use_with truetype freetype) || die "Configure failed"
	emake || die "Compile failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"

	dodoc ChangeLog README RELEASE || die "dodoc failed"
}
