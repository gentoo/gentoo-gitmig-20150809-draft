# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-session/xfce4-session-0.1.1.ebuild,v 1.1 2003/07/15 20:01:58 bcowan Exp $

IUSE=""
S=${WORKDIR}/${P}

DESCRIPTION="Xfce4 session manager"
HOMEPAGE="http://www.xfce.org"
SRC_URI="ftp://ftp.unix-ag.org/user/bmeurer/xfce4/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

DEPEND=">=x11-libs/gtk+-2.0.6                                                   
        dev-util/pkgconfig                                                      
        dev-libs/libxml2                                                        
        xfce-base/xfce4"                                                 

src_install() {
	make DESTDIR=${D} install || die
	
	dodoc AUTHORS INSTALL NEWS COPYING README ChangeLog TODO
}
