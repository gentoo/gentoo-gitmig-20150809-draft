# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/mplus-fonts/mplus-fonts-2.2.3.ebuild,v 1.10 2006/09/03 06:42:24 vapier Exp $

IUSE="X"

MY_P="mplus_bitmap_fonts-${PV}"

DESCRIPTION="M+ Japanese bitmap fonts"
HOMEPAGE="http://mplus-fonts.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/5030/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"

RDEPEND=""
DEPEND="${RDEPEND}
	|| ( ( x11-apps/bdftopcf
			x11-apps/mkfontdir
		)
		virtual/x11
	)
	dev-lang/perl"

S="${WORKDIR}/${MY_P}"
FONTPATH="/usr/share/fonts/mplus"

src_install(){

	DESTDIR="${D}${FONTPATH}" ./install_mplus_fonts || die
	dodoc README* INSTALL*
}
