# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/mplus-fonts/mplus-fonts-2.0.4.ebuild,v 1.1 2003/08/09 10:22:20 usata Exp $

FONT_PATH="/usr/share/fonts/mplus"
MY_P="mplus_bitmap_fonts-${PV}"

DESCRIPTION="mplus Japanese BDF FONTS"
HOMEPAGE="http://mplus-fonts.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/5030/${MY_P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc ~sparc"
IUSE="X"
DEPEND="virtual/x11
	dev-lang/perl"
RDEPEND="X? ( virtual/x11 )"
S="${WORKDIR}/${MY_P}"

src_install(){
	DESTDIR="${D}${FONT_PATH}" ./install_mplus_fonts || die
	dodoc README* INSTALL*
}

pkg_postinst(){
	einfo "You need you add following line into 'Section \"Files\"' in"
	einfo "XF86Config and reboot X Window System, to use these fonts."
	einfo ""
	einfo "\t FontPath \"${FONT_PATH}\""
	einfo ""
}

pkg_postrm(){
	einfo "You need you remove following line in 'Section \"Files\"' in"
	einfo "XF86Config, to unmerge this package completely."
	einfo ""
	einfo "\t FontPath \"${FONT_PATH}\""
	einfo ""
}
