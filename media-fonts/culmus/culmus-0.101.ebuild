# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/culmus/culmus-0.101.ebuild,v 1.2 2005/08/23 14:46:25 gustavoz Exp $

inherit font

DESCRIPTION="Hebrew Type1 fonts"
SRC_URI="mirror://sourceforge/culmus/${P}.tar.gz
	http://culmus.sourceforge.net/fancy/dorian.tar.gz
	http://culmus.sourceforge.net/fancy/gladia.tar.gz
	http://culmus.sourceforge.net/fancy/ozrad.tar.gz
	http://culmus.sourceforge.net/fancy/gan.tar.gz
	http://culmus.sourceforge.net/fancy/comix.tar.gz
	http://culmus.sourceforge.net/fancy/ktav-yad.tar.gz"
HOMEPAGE="http://culmus.sourceforge.net/"
KEYWORDS="~x86 ~ppc ~amd64 ~alpha ~sparc"
SLOT="0"
LICENSE="|| ( GPL-2 LICENSE-BITSTREAM )"
IUSE=""

FONT_SUFFIX="afm pfa"
DOCS="CHANGES LICENSE LICENSE-BITSTREAM"

src_unpack() {
	unpack ${A}
	mv *.{afm,pfa} ${S}
}

src_install () {
	font_src_install

	insinto /usr/share/fonts/${PN}
	doins *.conf
}

pkg_postinst() {
	einfo "Please add ${FONTPATH} to your FontPath"
	einfo "in XF86Config to make the fonts available to all X11 apps and"
	einfo "not just those that use fontconfig (the latter category includes"
	einfo "kde 3.1 and gnome 2.2)."
}
