# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/freefonts/freefonts-0.10-r2.ebuild,v 1.16 2005/08/23 00:09:36 vapier Exp $

DESCRIPTION="A Collection of Free Type1 Fonts"
HOMEPAGE="http://www.gimp.org/"
SRC_URI="mirror://gimp/fonts/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~alpha amd64 arm ppc ppc64 s390 sparc x86"
IUSE="X"

S=${WORKDIR}/freefont

src_install() {
	insinto /usr/share/fonts/freefont
	doins *.pfb || die "ins pfb"

	if use X ; then
		mkfontscale || die "mkfontscale"
		mkfontdir || die "mkfontdir"
		doins fonts.* || die "doins fonts"
	fi

	dodoc README *.license
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ] &&  [ -x /usr/bin/fc-cache ] ; then
		echo
		einfo "Creating font cache..."
		HOME="/root" /usr/bin/fc-cache -f
	fi

	einfo "The freefonts dir has been moved from /usr/X11R6/lib/X11/fonts/freefont to /usr/share/fonts/freefont ."
	einfo "Setting new fontpaths for X might be necessary in some cases."
}
