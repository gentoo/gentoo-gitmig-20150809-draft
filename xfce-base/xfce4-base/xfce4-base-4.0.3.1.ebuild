# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-base/xfce4-base-4.0.3.1.ebuild,v 1.1 2004/01/25 22:07:10 bcowan Exp $

IUSE=""
S=${WORKDIR}/${P}
XV="4.0.3"

DESCRIPTION="XFCE4, a lightweight Desktop Environment"
HOMEPAGE="http://www.xfce.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ia64 ~x86 ~ppc ~alpha ~sparc ~amd64 ~hppa"

DEPEND="=xfce-base/libxfce4util-${XV}
	=xfce-base/libxfcegui4-${XV}
	=xfce-base/libxfce4mcs-${XV}
	=xfce-base/xfce-mcs-manager-${XV}
	=xfce-base/xfce-mcs-plugins-${XV}
	=xfce-base/xfwm4-${PV}
	=xfce-base/xfce-utils-${XV}
	=xfce-base/xffm-${XV}
	=xfce-base/xfdesktop-${XV}
	=xfce-base/xfprint-${XV}
	>=x11-themes/gtk-engines-xfce-2.1.1
	=xfce-base/xfce4-panel-${XV}"

src_install() {
	dodir /etc/X11/Sessions
	echo startxfce4 > ${D}/etc/X11/Sessions/XFCE-4
	fperms 755 /etc/X11/Sessions/XFCE-4

	einfo "This is just a wrapper script to install all the base components of Xfce4"
	einfo "Use startxfce4 to initialize. You also might want to emerge the extras"
	einfo "like xffm-icons, xfwm4-themes,xfce4-mixer, and xfce4-toys or"
	einfo "emerge xfce4 to merge all the base and extras."
}
