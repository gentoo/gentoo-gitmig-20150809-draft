# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/culmus/culmus-0.100-r1.ebuild,v 1.7 2005/08/24 00:01:36 smithj Exp $

DESCRIPTION="Hebrew Type1 fonts"
SRC_URI="mirror://sourceforge/culmus/${P}.tar.gz
	http://culmus.sourceforge.net/fancy/dorian.tar.gz
	http://culmus.sourceforge.net/fancy/gladia.tar.gz
	http://culmus.sourceforge.net/fancy/ozrad.tar.gz
	http://culmus.sourceforge.net/fancy/gan.tar.gz
	http://culmus.sourceforge.net/fancy/comix.tar.gz
	http://culmus.sourceforge.net/fancy/ktav-yad.tar.gz"
HOMEPAGE="http://culmus.sourceforge.net/"
KEYWORDS="x86 ppc ~amd64 alpha"
SLOT="0"
LICENSE="|| ( GPL-2 LICENSE-BITSTREAM )"
IUSE=""

FONTPATH="/usr/share/fonts/${PN}"

src_install () {
	dodir ${FONTPATH}
	cp -pPR * ${D}${FONTPATH}
	cp -pPR ${WORKDIR}/*.{afm,pfa}  ${D}${FONTPATH}
	rm ${D}${FONTPATH}/{CHANGES,LICENSE,LICENSE-BITSTREAM,GNU-GPL,culmus.spec}
	dodoc CHANGES LICENSE LICENSE-BITSTREAM
}

pkg_postinst() {
	einfo "Please add ${FONTPATH} to your FontPath"
	einfo "in XF86Config to make the fonts available to all X11 apps and"
	einfo "not just those that use fontconfig (the latter category includes"
	einfo "kde 3.1 and gnome 2.2)."
}
