# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/sharefonts/sharefonts-0.10-r2.ebuild,v 1.3 2004/06/24 22:31:00 agriffis Exp $

S=${WORKDIR}/sharefont
DESCRIPTION="A Collection of True Type Fonts"
SRC_URI="mirror://gimp/fonts/${P}.tar.gz"
HOMEPAGE="http://www.gimp.org/"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
SLOT="0"
LICENSE="public-domain"
IUSE="X"

FONTPATH="/usr/share/fonts/sharefont"

src_install () {

	insinto ${FONTPATH}
	doins * || die
	if use X ; then
		mkfontscale ${D}${FONTPATH}
		mkfontdir ${D}${FONTPATH}
		if [ -x /usr/bin/fc-cache ] ; then
			HOME="/root" /usr/bin/fc-cache -f ${D}${FONTPATH}
		fi
	fi
	rm  ${D}${FONTPATH}/README
	dodoc README

}

pkg_postinst () {
	einfo "The sharefonts dir has been moved from /usr/X11R6/lib/X11/fonts/sharefont to ${FONTPATH}."
	einfo "Setting new fontpaths for X might be necessary in some cases."
}
