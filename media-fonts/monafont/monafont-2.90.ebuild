# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/monafont/monafont-2.90.ebuild,v 1.1 2003/09/10 10:20:36 usata Exp $

IUSE="truetype"

MY_P=${P/_/}

DESCRIPTION="Japanese bitmap and TrueType fonts suitable for browsing 2ch"
HOMEPAGE="http://monafont.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2
	truetype? mirror://sourceforge/${PN}/${PN}-ttf-${PV}.zip"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc ~sparc"
IUSE=""
DEPEND="virtual/x11
	dev-lang/perl
	sys-apps/sed"
RDEPEND=""

S="${WORKDIR}/${MY_P}"
FONTDIR=/usr/share/fonts/${PN}
TTFONTDIR=/usr/share/fonts/ttf/ja/${PN}

src_compile(){

	emake || die
}

src_install(){

	make install X11FONTDIR=${D}/${FONTDIR} || die
	mkfontdir ${D}/${FONTDIR}
	insinto ${FONTDIR}
	newins fonts.alias.mona fonts.alias
	dodoc README*

	if [ -n "`use truetype`" ] ; then
		cd ${WORKDIR}
		insinto ${TTFONTDIR}
		doins mona.ttf
		mkfontscale ${D}/${TTFONTDIR}
		newins ${D}/${TTFONTDIR}/fonts.scale fonts.dir
		fc-cache ${D}/${TTFONTDIR}
		dodoc README-ttf.txt
	fi
}

pkg_postinst(){

	einfo
	einfo "You need to add following line into 'Section \"Files\"' in"
	einfo "XF86Config and reboot X Window System, to use these fonts."
	einfo
	einfo "\tFontPath \"${FONTDIR}\""
	einfo
}

pkg_postrm(){

	einfo
	einfo "You need to remove following line in 'Section \"Files\"' in"
	einfo "XF86Config, to unmerge this package completely."
	einfo
	einfo "\tFontPath \"${FONTDIR}\""
	einfo
}
