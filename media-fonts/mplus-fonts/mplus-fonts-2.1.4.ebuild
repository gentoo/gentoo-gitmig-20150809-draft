# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/mplus-fonts/mplus-fonts-2.1.4.ebuild,v 1.1 2004/01/25 16:21:57 usata Exp $

IUSE="X"

MY_P="mplus_bitmap_fonts-${PV}"

DESCRIPTION="M+ Japanese bitmap fonts"
HOMEPAGE="http://mplus-fonts.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/5030/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~alpha"

DEPEND="virtual/x11
	dev-lang/perl"
RDEPEND="X? ( virtual/x11 )"

S="${WORKDIR}/${MY_P}"
FONTPATH="/usr/share/fonts/mplus"

src_install(){

	DESTDIR="${D}${FONTPATH}" ./install_mplus_fonts || die
	dodoc README* INSTALL*
}
