# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4/xfce4-4.4.1.ebuild,v 1.11 2007/08/18 14:41:38 angelos Exp $

inherit xfce44

XFCE_VERSION=4.4.1
xfce44

HOMEPAGE="http://www.xfce.org"
DESCRIPTION="Meta package for Xfce4 desktop, merge this package to install."
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="alsa cups minimal oss xscreensaver"

RDEPEND=">=x11-themes/gtk-engines-xfce-2.4
	>=xfce-base/thunar-${THUNAR_MASTER_VERSION}
	>=xfce-base/xfce-mcs-plugins-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce4-panel-${XFCE_MASTER_VERSION}
	>=xfce-base/xfwm4-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce-utils-${XFCE_MASTER_VERSION}
	>=xfce-base/xfdesktop-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce4-session-${XFCE_MASTER_VERSION}
	>=xfce-extra/xfce4-icon-theme-${XFCE_MASTER_VERSION}
	alsa? ( >=xfce-extra/xfce4-mixer-${XFCE_MASTER_VERSION} )
	oss? ( >=xfce-extra/xfce4-mixer-${XFCE_MASTER_VERSION} )
	cups? ( >=xfce-base/xfprint-${XFCE_MASTER_VERSION} )
	!minimal? ( >=xfce-base/orage-${XFCE_MASTER_VERSION}
		>=xfce-extra/mousepad-0.2.12
		>=xfce-extra/xfwm4-themes-${XFCE_MASTER_VERSION}
		>=xfce-extra/terminal-0.2.6
		>=xfce-extra/xfce4-appfinder-${XFCE_MASTER_VERSION} )
	xscreensaver? ( >=x11-misc/xscreensaver-5.02 )"
DEPEND="${RDEPEND}"

# hack to avoid exporting function from eclass.
# we need eclass to get _MASTER_VERSION.
src_compile() {
	echo
}

src_install() {
	dodir /etc/X11/Sessions
	echo startxfce4 > ${D}/etc/X11/Sessions/Xfce4
	fperms 755 /etc/X11/Sessions/Xfce4
}

pkg_postinst() {
	elog
	elog "Run Xfce4 from your favourite Display Manager by using"
	elog "XSESSION=\"Xfce4\" in /etc/rc.conf"
	elog
}
