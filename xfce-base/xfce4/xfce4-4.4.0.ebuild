# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4/xfce4-4.4.0.ebuild,v 1.2 2007/01/23 17:32:34 welp Exp $

inherit xfce44

xfce44

DESCRIPTION="Meta package for Xfce4 desktop, merge this package to install"
HOMEPAGE="http://www.xfce.org/"
LICENSE="GPL-2 BSD LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
IUSE="alsa cups minimal oss svg"

DEPEND="svg? ( gnome-base/librsvg )"
RDEPEND="${DEPEND}
	>=x11-themes/gtk-engines-xfce-2.4
	>=xfce-base/thunar-${THUNAR_MASTER_VERSION}
	>=xfce-base/xfce-mcs-plugins-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce4-panel-${XFCE_MASTER_VERSION}
	>=xfce-base/xfwm4-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce-utils-${XFCE_MASTER_VERSION}
	>=xfce-base/xfdesktop-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce4-session-${XFCE_MASTER_VERSION}
	>=xfce-extra/xfce4-appfinder-${XFCE_MASTER_VERSION}
	>=xfce-extra/xfce4-icon-theme-${XFCE_MASTER_VERSION}
	alsa? ( >=xfce-extra/xfce4-mixer-${XFCE_MASTER_VERSION} )
	oss? ( >=xfce-extra/xfce4-mixer-${XFCE_MASTER_VERSION} )
	cups? ( >=xfce-base/xfprint-${XFCE_MASTER_VERSION} )
	!minimal? ( >=xfce-base/orage-${XFCE_MASTER_VERSION}
		    >=xfce-extra/mousepad-0.2.10
		    >=xfce-extra/xfwm4-themes-${XFCE_MASTER_VERSION}
		    >=xfce-extra/terminal-0.2.6 )"

src_install() {
	dodir /etc/X11/Sessions
	echo startxfce4 > ${D}/etc/X11/Sessions/Xfce4
	fperms 755 /etc/X11/Sessions/Xfce4
}
