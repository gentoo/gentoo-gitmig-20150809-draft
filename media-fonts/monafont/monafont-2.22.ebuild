# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/monafont/monafont-2.22.ebuild,v 1.9 2004/07/14 17:07:33 agriffis Exp $

DESCRIPTION="Japanese bitmap fonts suitable for browsing 2ch"
HOMEPAGE="http://monafont.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 alpha ppc sparc"
IUSE=""
DEPEND="virtual/x11
	dev-lang/perl
	sys-apps/sed"
RDEPEND=""

FONTDIR=/usr/share/fonts/${PN}

src_unpack() {

	unpack ${A}
	sed -i -e 's:$(X11BINDIR)/mkdirhier:/bin/mkdir -p:' ${S}/Makefile
}

src_compile(){

	PERL_BADLANG=0 ; LC_CTYPE=C
	export PERL_BADLANG LC_CTYPE
	emake || die
}

src_install(){

	emake install X11FONTDIR=${D}/${FONTDIR} || die
	mkfontdir ${D}/${FONTDIR}
	insinto ${FONTDIR}
	newins fonts.alias.mona fonts.alias

	dodoc README*
}

pkg_postinst(){
	einfo "You need you add following line into 'Section \"Files\"' in"
	einfo "XF86Config and reboot X Window System, to use these fonts."
	einfo ""
	einfo "\tFontPath \"${FONTDIR}\""
	einfo ""
}

pkg_postrm(){
	einfo "You need you remove following line in 'Section \"Files\"' in"
	einfo "XF86Config, to unmerge this package completely."
	einfo ""
	einfo "\tFontPath \"${FONTDIR}\""
	einfo ""
}
