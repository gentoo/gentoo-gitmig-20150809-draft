# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: 

IUSE=""
S=${WORKDIR}/${P}

DESCRIPTION="Xfce4 Mixer"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://sourceforge/xfce/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

DEPEND=">=x11-libs/gtk+-2.0.6
	dev-util/pkgconfig
	dev-libs/libxml2
	=x11-wm/xfce4-3.90.0"

src_install() {
        make DESTDIR=${D} install || die
                                                                                                                                           
        dodoc AUTHORS INSTALL NEWS COPYING README ChangeLog TODO
}
