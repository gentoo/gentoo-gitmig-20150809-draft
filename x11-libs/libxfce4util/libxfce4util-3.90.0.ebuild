# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libxfce4util/libxfce4util-3.90.0.ebuild,v 1.2 2003/06/24 05:53:29 bcowan Exp $ 

IUSE=""
S=${WORKDIR}/${P}

DESCRIPTION="Library's for XFCE4"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://sourceforge/xfce/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

DEPEND=">=x11-libs/gtk+-2.0.6
	dev-util/pkgconfig
	dev-libs/libxml2"

src_install() {
        make DESTDIR=${D} install || die
                                                                                                                                           
        dodoc AUTHORS INSTALL NEWS COPYING README ChangeLog
}
