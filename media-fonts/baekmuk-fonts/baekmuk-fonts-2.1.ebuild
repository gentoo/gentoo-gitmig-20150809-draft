# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/baekmuk-fonts/baekmuk-fonts-2.1.ebuild,v 1.2 2003/07/03 19:40:38 gmsoft Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Korean Baekmuk Font"
SRC_URI="http://gentoo.or.kr/distfiles/baekmuk-fonts/${P}.tar.gz"

SLOT="0"
LICENSE="BAEKMUK"
KEYWORDS="~x86 ~ppc ~sparc hppa"

DEPEND="virtual/x11"

src_install () {
	dodir /usr/X11R6/lib/X11/fonts/baekmuk-2.1
	dodir /usr/share/fonts/ttf/korean/baekmuk-2.1
	
	mv ${S}/bdf/{*.bdf,fonts.dir} \
		${D}/usr/X11R6/lib/X11/fonts/baekmuk-2.1/
	mv ${S}/ttf/* ${D}/usr/share/fonts/ttf/korean/baekmuk-2.1/
	
	dodoc README COPYRIGHT COPYRIGHT.ks hconfig.ps
}

pkg_postinst() {
	einfo "You MUST add the path of Backmuk fonts in /etc/X11/XF86Config"

	einfo ""
	einfo "\tSection \"Files\""
	einfo "\t\tFontPath \"/usr/X11R6/lib/X11/fonts/baekmuk-2.1/\"           *"
	einfo ""

	einfo "If you use xft, do"
	einfo ""
	einfo "\t\tdir \"/usr/share/fonts/ttf/korean/baekmuk-2.1\""
	einfo ""
	einfo "and then"
	einfo ""
	einfo "# cd /usr/share/fonts/ttf/korean/baekmuk-2.1/"
	einfo "# /usr/X11R6/bin/xftcache"
	einfo ""
	einfo "Lastly, you must restart your X server"

}
