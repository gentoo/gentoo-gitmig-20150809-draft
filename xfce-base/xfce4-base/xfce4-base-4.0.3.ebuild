# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-base/xfce4-base-4.0.3.ebuild,v 1.1 2004/01/09 05:35:53 bcowan Exp $

IUSE=""
S=${WORKDIR}/${P}

DESCRIPTION="XFCE4, a lightweight Desktop Environment"
HOMEPAGE="http://www.xfce.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ia64 ~x86 ~ppc ~alpha ~sparc ~amd64 ~hppa"

DEPEND="=xfce-base/libxfce4util-${PV}
	=xfce-base/libxfcegui4-${PV}
	=xfce-base/libxfce4mcs-${PV}
	=xfce-base/xfce-mcs-manager-${PV}
	=xfce-base/xfce-mcs-plugins-${PV}
	=xfce-base/xfwm4-${PV}
	=xfce-base/xfce-utils-${PV}
	=xfce-base/xffm-${PV}
	=xfce-base/xfdesktop-${PV}
	=xfce-base/xfprint-${PV}
	>=x11-themes/gtk-engines-xfce-2.1.1
	=xfce-base/xfce4-panel-${PV}"

src_install() {
	dodir /etc/X11/Sessions
	echo startxfce4 > ${D}/etc/X11/Sessions/XFCE-4
	fperms 755 /etc/X11/Sessions/XFCE-4

	einfo "This is just a wrapper script to install all the base components of Xfce4"
	einfo "Use startxfce4 to initialize. You also might want to emerge the extras"
	einfo "like xffm-icons, xfwm4-themes,xfce4-mixer, and xfce4-toys or"
	einfo "emerge xfce4 to merge all the base and extras."
}
