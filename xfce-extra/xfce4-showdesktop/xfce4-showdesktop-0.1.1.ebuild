# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-showdesktop/xfce4-showdesktop-0.1.1.ebuild,v 1.2 2003/09/04 00:04:30 bcowan Exp $ 

IUSE=""
MY_P="${PN}-plugin-${PV}"
S=${WORKDIR}/${PN}-plugin

DESCRIPTION="Xfce4 panel plugin to hide/show desktop"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="http://download.berlios.de/xfce-goodies/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

DEPEND=">=x11-libs/gtk+-2.0.6
	dev-util/pkgconfig
	dev-libs/libxml2
	xfce-base/xfce4-base"

src_install() {
	make DESTDIR=${D} install || die
                                                                                                                                           
        dodoc AUTHORS INSTALL COPYING README 
}
