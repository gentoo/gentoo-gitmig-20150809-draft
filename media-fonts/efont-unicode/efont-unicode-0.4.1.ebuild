# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/efont-unicode/efont-unicode-0.4.1.ebuild,v 1.3 2004/01/15 22:13:47 usata Exp $

IUSE="X"

MY_P="${PN}-bdf-${PV}"

DESCRIPTION="The /efont/ Unicode Bitmap Fonts"
HOMEPAGE="http://openlab.jp/efont/unicode/"
SRC_URI="http://openlab.jp/efont/dist/unicode-bdf/${MY_P}.tar.bz2"

# naga10 has free-noncomm license
LICENSE="public-domain BAEKMUK X11 as-is"
SLOT="0"
KEYWORDS="~x86 ~alpha ~sparc ~ppc"

DEPEND="virtual/x11"
RDEPEND=""

S="${WORKDIR}/${MY_P}"
FONTDIR="/usr/share/fonts/efont-unicode"

src_compile () {

	for i in *.bdf ; do
		echo "Converting $i into ${i/bdf/pcf} ..."
		/usr/X11R6/bin/bdftopcf -o ${i/bdf/pcf} ${i} || die
		echo "Compressing ${i/bdf/pcf} ..."
		gzip -9 ${i/bdf/pcf} || die
	done
}

src_install () {

	insinto ${FONTDIR}
	doins *.pcf.gz || die

	dodoc README* COPYRIGHT ChangeLog INSTALL
	dohtml List.html

	/usr/X11R6/bin/mkfontdir ${D}${FONTDIR}
}

pkg_postinst() {

	einfo
	einfo "You need to add following line into 'Section \"Files\"' in"
	einfo "XF86Config and reboot X Window System, to use these fonts."
	einfo
	einfo "\t FontPath \"${FONTDIR}\""
	einfo
}

pkg_postrm(){

	einfo
	einfo "You need to remove following line from 'Section \"Files\"' in"
	einfo "XF86Config, to unmerge this package completely."
	einfo
	einfo "\t FontPath \"${FONTDIR}\""
	einfo
}
