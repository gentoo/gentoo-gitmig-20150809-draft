# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/xfce4/xfce4-3.90.0.ebuild,v 1.7 2003/06/24 05:40:38 bcowan Exp $ 

IUSE=""
S=${WORKDIR}/${P}

DESCRIPTION="XFCE4, a lightweight Desktop Environment"
HOMEPAGE="http://www.xfce.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"

DEPEND=">=x11-libs/gtk+-2.0.6
	dev-util/pkgconfig
	dev-libs/libxml2
	=x11-libs/libxfce4util-3.90.0
	=x11-libs/libxfcegui4-3.90.0
	=x11-libs/libxfce4mcs-3.90.0
	=x11-misc/xfce-mcs-manager-3.90.0
	=x11-misc/xfce-mcs-plugins-3.90.0
	=x11-wm/xfwm4-3.90.0
	=x11-misc/xfce-utils-3.90.0
	=app-misc/xffm-3.90.381
	=x11-misc/xfdesktop-3.90.0
	=x11-misc/xfprint-3.90.0
	=x11-misc/xfce4-iconbox-3.90.0
	=x11-themes/gtk-engines-xfce-2.1.1
	=x11-misc/xfce4-panel-3.90.0"

src_install() {
	dodir /etc/X11/Sessions
	echo startxfce4 > ${D}/etc/X11/Sessions/XFCE-4
	fperms 755 /etc/X11/Sessions/XFCE-4
	
	einfo "This is just a wrapper script to install all the components of Xfce4"
	einfo "Use startxfce4 to initialize. You also might want to emerge the extras"
	einfo "like xffm-icons, xfwm4-themes,xfce4-mixer, and xfce4-toys."	
}

