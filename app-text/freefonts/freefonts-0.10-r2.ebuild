# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/freefonts/freefonts-0.10-r2.ebuild,v 1.1 2003/04/30 12:22:26 foser Exp $

S=${WORKDIR}/freefont
DESCRIPTION="A Collection of Free True Type Fonts"
SRC_URI="ftp://ftp.gimp.org/pub/gimp/fonts/${P}.tar.gz"
HOMEPAGE="http://www.gimp.org"
KEYWORDS="~x86 ~sparc ~ppc"
SLOT="0"
LICENSE="freedist"
IUSE="X"

src_install () {
	insinto /usr/share/fonts/freefont
	doins *.pfb 

	if [ -n "`use X`" ] ;
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
