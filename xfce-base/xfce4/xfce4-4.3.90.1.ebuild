# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4/xfce4-4.3.90.1.ebuild,v 1.1 2006/04/20 06:05:27 dostrow Exp $

DESCRIPTION="Xfce 4 base ebuild"
HOMEPAGE="http://www.xfce.org/"
LICENSE="GPL-2 BSD LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
IUSE=""

RDEPEND="~x11-themes/gtk-engines-xfce-2.3.90.1
	~xfce-base/xfce-mcs-plugins-${PV}
	~xfce-base/xfce4-panel-${PV}
	~xfce-base/xfwm4-${PV}
	~xfce-base/xfce-utils-${PV}
	~xfce-base/xfdesktop-${PV}
	~xfce-base/xfce4-session-${PV}
	~xfce-base/xfprint-${PV}
	~xfce-base/orage-${PV}
	~xfce-extra/xfwm4-themes-${PV}
	~xfce-extra/xfce4-appfinder-${PV}
	~xfce-extra/xfce4-icon-theme-${PV}
	~xfce-extra/terminal-0.2.5.1_beta1
	~xfce-extra/xfce4-mixer-${PV}
	~xfce-extra/mousepad-0.2.4"

src_install() {
	dodir /etc/X11/Sessions
	echo startxfce4 > ${D}/etc/X11/Sessions/Xfce-4
	fperms 755 /etc/X11/Sessions/Xfce-4
}

pkg_postinst() {
	ewarn "This is a beta ebuild. Please do not file bugs for any of the"
	ewarn "packages included in this meta-pacakge as they will all be"
	ewarn "forwarded upstream and the bugs closed as INVALID."
	einfo "Bugs specific to the ebuilds themselves are welcome."
}
