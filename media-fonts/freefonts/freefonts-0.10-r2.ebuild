# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/freefonts/freefonts-0.10-r2.ebuild,v 1.12 2004/11/01 17:41:15 corsair Exp $

S=${WORKDIR}/freefont
DESCRIPTION="A Collection of Free Type1 Fonts"
SRC_URI="mirror://gimp/fonts/${P}.tar.gz"
HOMEPAGE="http://www.gimp.org"
KEYWORDS="x86 sparc ppc amd64 ~ppc64"
SLOT="0"
LICENSE="freedist"
IUSE="X"

src_install () {
	insinto /usr/share/fonts/freefont
	doins *.pfb

	if use X ;
	then
		mkfontscale
		mkfontdir
		doins fonts.*
	fi

	dodoc README *.license
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ] &&  [ -x /usr/bin/fc-cache ]
	then
		echo
		einfo "Creating font cache..."
		HOME="/root" /usr/bin/fc-cache -f
	fi

	einfo "The freefonts dir has been moved from /usr/X11R6/lib/X11/fonts/freefont to /usr/share/fonts/freefont ."
	einfo "Setting new fontpaths for X might be necessary in some cases."
}
