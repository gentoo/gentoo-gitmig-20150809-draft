# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 

IUSE=""
DESCRIPTION="Xfce 4 panel"
SRC_URI="http://www.xfce.org/archive/xfce-${PV}/src/${P}.tar.gz"
HOMEPAGE="http://xfce.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ia64 ~x86 ~ppc ~alpha ~sparc ~amd64 ~hppa ~mips"

RDEPEND="virtual/x11
	>=x11-libs/gtk+-2.2*
	dev-libs/libxml2
	gnome-base/librsvg                                                      
	x11-libs/startup-notification
	=xfce-base/libxfce4util-4.1.90                                           
        =xfce-base/libxfcegui4-4.1.90                                            
        =xfce-base/libxfce4mcs-4.1.90                                            
        =xfce-base/xfce-mcs-manager-4.1.90"
DEPEND="${RDEPEND} 	                                                             
        dev-util/pkgconfig
	!<xfce-base/xfce4-panel-4.1.90"	

src_install () {
	make DESTDIR=${D} install || die
	dodoc ChangeLog* AUTHORS README* TODO*
}
