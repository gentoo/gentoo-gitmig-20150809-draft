# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/XWine/XWine-0.2.2.ebuild,v 1.1 2002/08/19 21:28:46 raker Exp $
DESCRIPTION="Gtk frontend for Wine emulator"

MY_P=${P}_en

HOMEPAGE="http://darken.tuxfamily.org/pages/xwine_en.html"

SRC_URI="http://darken.tuxfamily.org/projets/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"

KEYWORDS="x86"
DEPEND=">=x11-libs/gtk+-1.2.10-r8
	    >=gnome-base/libgnome-2.0.1-r1
	    >=net-www/mozilla-1.0-r2
	    >=app-emulation/wine-20020710-r1"

RDEPEND="${DEPEND}
	    >=app-emulation/winesetuptk-0.6.0b-r2"


S="${WORKDIR}/${MY_P}"

src_compile() {
	./configure \
	    --prefix=/usr \
	    emake || die
}

src_install () {
	make \
	    prefix=${D}/usr \
	    install || die

	# Don't need to install docs twice
	rm -rf ${D}/usr/share/doc/xwine

	dodoc doc/Manual* FAQ* BUGS COPYING AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	
	einfo
	einfo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	einfo "! ${PN} requires a setup Wine to start....It is recommended    !"
	einfo "! that you run winesetuptk prior to running ${PN} to setup     !"
	einfo "! a base Wine install                                          !"
	einfo "!                      THXS                                    !"
	einfo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
}	
