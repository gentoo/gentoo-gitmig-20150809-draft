# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/sharefonts/sharefonts-0.10-r2.ebuild,v 1.1 2004/05/15 10:44:27 usata Exp $

S=${WORKDIR}/sharefont
DESCRIPTION="A Collection of True Type Fonts"
SRC_URI="mirror://gimp/fonts/${P}.tar.gz"
HOMEPAGE="http://www.gimp.org/"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
SLOT="0"
LICENSE="public-domain"

FONTPATH="/usr/share/fonts/${PN}"

src_install () {

	insinto ${FONTPATH}
	doins * || die
	rm  ${D}${FONTPATH}/README
	dodoc README

}
