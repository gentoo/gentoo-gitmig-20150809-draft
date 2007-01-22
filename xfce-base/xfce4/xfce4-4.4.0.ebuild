# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4/xfce4-4.4.0.ebuild,v 1.1 2007/01/22 14:11:36 nichoj Exp $

DESCRIPTION="Meta package for Xfce4 desktop, merge this package to install"
HOMEPAGE="http://www.xfce.org/"
LICENSE="GPL-2 BSD LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
IUSE="alsa cups minimal oss svg"

DEPEND="svg? ( gnome-base/librsvg )"
RDEPEND="${DEPEND}
	>=x11-themes/gtk-engines-xfce-2.4
	>=xfce-base/xfce-mcs-plugins-${PV}
	>=xfce-base/xfce4-panel-${PV}
	>=xfce-base/xfwm4-${PV}
	>=xfce-base/xfce-utils-${PV}
	>=xfce-base/xfdesktop-${PV}
	>=xfce-base/xfce4-session-${PV}
	cups? ( >=xfce-base/xfprint-${PV} )
	!minimal? ( >=xfce-base/orage-${PV} )
	!minimal? ( >=xfce-base/thunar-0.8 )
	!minimal? ( >=xfce-extra/xfwm4-themes-${PV} )
	>=xfce-extra/xfce4-appfinder-${PV}
	>=xfce-extra/xfce4-icon-theme-${PV}
	!minimal? ( >=xfce-extra/terminal-0.2.6 )
	oss? ( >=xfce-extra/xfce4-mixer-${PV} )
	alsa? ( >=xfce-extra/xfce4-mixer-${PV} )
	!minimal? ( >=xfce-extra/mousepad-0.2.10 )"

src_install() {
	dodir /etc/X11/Sessions
	echo startxfce4 > ${D}/etc/X11/Sessions/Xfce4
	fperms 755 /etc/X11/Sessions/Xfce4
}
