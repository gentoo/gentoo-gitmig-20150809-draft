# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-systemload/xfce4-systemload-0.3.0.ebuild,v 1.1 2003/07/15 18:41:24 bcowan Exp $ 

IUSE=""
MY_P="${PN}-plugin-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Xfce trigger launcher"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="http://ricpersi.altervista.org/download/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

DEPEND=">=x11-libs/gtk+-2.0.6
	dev-util/pkgconfig
	dev-libs/libxml2
	xfce-base/xfce4"

src_install() {
	make DESTDIR=${D} install || die
                                                                                                                                           
        dodoc AUTHORS INSTALL COPYING README 
}
