# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/culmus/culmus-0.101-r1.ebuild,v 1.7 2007/08/13 20:54:52 dertobi123 Exp $

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
KEYWORDS="alpha ~amd64 arm ia64 ppc s390 sh sparc x86 ~x86-fbsd"
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

	insinto /etc/fonts/conf.d/
	doins culmus.conf
	dosym /etc/fonts/conf.d/culmus.conf /etc/fonts/conf.d/10-culmus.conf
}

pkg_postinst() {
	elog "Please add ${FONTPATH} to your FontPath"
	elog "in XF86Config to make the fonts available to all X11 apps and"
	elog "not just those that use fontconfig (the latter category includes"
	elog "kde 3.1 and gnome 2.2)."
}
