# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/culmus/culmus-0.102.ebuild,v 1.3 2008/12/09 15:24:28 ranger Exp $

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
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
SLOT="0"
LICENSE="|| ( GPL-2 LICENSE-BITSTREAM )"
IUSE=""

S="${WORKDIR}/${P}"
FONT_S="${S}"
FONT_SUFFIX="afm pfa ttf"
FONT_CONF=( "65-culmus.conf" )
DOCS="CHANGES"

src_unpack() {
	unpack ${A}
	mv *.afm *.pfa "${S}"/
	cd "${S}"
	mv culmus.conf 65-culmus.conf
}

pkg_postinst() {
	elog "This font contains support for fontconfig, which may make"
	elog "it render more smoothly. To enable it, do:"
	elog "eselect fontconfig enable 65-culmus.conf"
}
