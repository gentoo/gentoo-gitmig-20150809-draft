# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/mplus-fonts/mplus-fonts-2.2.4.ebuild,v 1.2 2006/01/12 04:37:45 robbat2 Exp $

IUSE="X"

MY_P="mplus_bitmap_fonts-${PV}"

DESCRIPTION="M+ Japanese bitmap fonts"
HOMEPAGE="http://mplus-fonts.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/5030/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc ~sparc ~hppa ~mips ~amd64 ~ia64 ~ppc64"

DEPEND="|| ( ( x11-apps/mkfontdir x11-apps/bdftopcf ) virtual/x11 )
		dev-lang/perl"
RDEPEND=""

S="${WORKDIR}/${MY_P}"
FONTPATH="/usr/share/fonts/mplus"

src_install(){
	DESTDIR="${D}${FONTPATH}" ./install_mplus_fonts || die
	dodoc README* INSTALL*
}
