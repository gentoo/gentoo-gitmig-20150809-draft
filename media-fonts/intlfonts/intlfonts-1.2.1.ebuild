# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/intlfonts/intlfonts-1.2.1.ebuild,v 1.3 2004/07/29 19:04:40 kugelfang Exp $

inherit font

IUSE="X bdf"

DESCRIPTION="International X11 fixed fonts"
HOMEPAGE="http://www.gnu.org/directory/intlfonts.html"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"

DEPEND="virtual/x11
	media-libs/fontconfig"
RDEPEND="X? ( virtual/x11 )"

src_compile() {
	cd ${S}
	econf --with-fontdir=/usr/share/fonts/${PN} || die
}

src_install() {
	make install fontdir=${D}/usr/share/fonts/${PN} || die
	find ${D}/usr/share/fonts/${PN} -name '*.pcf' | xargs gzip -9
	use bdf || rm -rf ${D}/usr/share/fonts/${PN}/bdf
	dodoc ChangeLog NEWS README
	dodoc Emacs.ap
	font_xfont_config
	font_xft_config
}
