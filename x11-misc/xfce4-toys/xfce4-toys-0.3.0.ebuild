# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xfce4-toys/xfce4-toys-0.3.0.ebuild,v 1.1 2003/06/13 19:06:37 bcowan Exp $

IUSE=""
S=${WORKDIR}/${P}

DESCRIPTION="Xfce4 toys"
HOMEPAGE="http://www.xfce.org"
SRC_URI="mirror://sourceforge/xfce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

DEPEND=">=x11-libs/gtk+-2.0.6                                                   
        dev-util/pkgconfig                                                      
        dev-libs/libxml2                                                        
        =x11-wm/xfce4-3.90.0"                                                 

src_install() {
	make DESTDIR=${D} install || die
	
	dodoc AUTHORS INSTALL NEWS COPYING README ChangeLog TODO
}
