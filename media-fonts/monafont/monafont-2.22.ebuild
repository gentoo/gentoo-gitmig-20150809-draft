# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/monafont/monafont-2.22.ebuild,v 1.3 2003/08/09 10:39:02 usata Exp $

DESCRIPTION="Japanese bitmap fonts suitable for browsing 2ch"
HOMEPAGE="http://monafont.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 alpha ~ppc ~sparc"
IUSE=""
DEPEND="virtual/x11
	dev-lang/perl
	sys-apps/sed"
RDEPEND=""

S="${WORKDIR}/${P}"
FONTDIR=/usr/share/fonts/${PN}

src_compile(){
	emake || die
}

src_install(){

	emake install X11FONTDIR=${D}/${FONTDIR} || die
	mkfontdir ${D}/${FONTDIR}
	install -c fonts.alias.mona ${D}/${FONTDIR}/fonts.alias

	dodoc README*
}

pkg_postinst(){
	einfo "You need you add following line into 'Section \"Files\"' in"
	einfo "XF86Config and reboot X Window System, to use these fonts."
	einfo ""
	einfo "\tFontPath \"${FONTDIR}/${PN}\""
	einfo ""
}

pkg_postrm(){
	einfo "You need you remove following line in 'Section \"Files\"' in"
	einfo "XF86Config, to unmerge this package completely."
	einfo ""
	einfo "\t FontPath \"${FONTDIR}/${PN}\""
	einfo ""
}
