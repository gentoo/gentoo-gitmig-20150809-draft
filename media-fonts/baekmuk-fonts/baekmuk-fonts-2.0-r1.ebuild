# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/baekmuk-fonts/baekmuk-fonts-2.0-r1.ebuild,v 1.1 2003/06/02 13:46:55 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Korean Baekmuk Font"
SRC_URI="ftp://ftp.nnongae.com/pub/gentoo/${P}.tar.gz"
HOMEPAGE="ftp://ftp.nnongae.com/pub/gentoo/"

SLOT="0"
LICENSE="BAEKMUK"
KEYWORDS="x86 sparc  ppc"

DEPEND="virtual/x11"

src_install () {
	dodir /usr/X11R6/lib/X11/fonts/baekmuk
	dodir /usr/share/fonts/ttf/korean/baekmuk
	
	mv ${S}/{*.pcf.gz,fonts.dir,fonts.alias} \
		${D}/usr/X11R6/lib/X11/fonts/baekmuk/
	mv ${S}/ttf/* ${D}/usr/share/fonts/ttf/korean/baekmuk/
	
	dodoc COPYRIGHT COPYRIGHT.ks hconfig.ps
}

pkg_postinst() {
        einfo "You must add the path of Baekmuk fonts in the /etc/X11/XF86Config:"
        einfo ""
        einfo "\tSection \"Files\""
        einfo "\t\tFontPath \"/usr/X11R6/lib/X11/fonts/baekmuk/\""
        einfo ""
        einfo "You should restart your X server after that."
}
