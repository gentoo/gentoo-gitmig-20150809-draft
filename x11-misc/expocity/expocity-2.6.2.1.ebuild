# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/expocity/expocity-2.6.2.1.ebuild,v 1.1 2004/11/07 13:13:25 pyrania Exp $

inherit gnome2

DESCRIPTION="Windowmanager expocity is an effort to integrate an efficient means of switching between applications into the window manager metacity similar to Expose on Apple's OS-X."

HOMEPAGE="http://www.pycage.de/software_expocity.html"
MY_P=${P/.1/-1}
SRC_URI="http://www.pycage.de/download/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
IUSE="xinerama"
KEYWORDS="~x86"

RDEPEND="virtual/x11
		>=x11-libs/pango-1.2
		>=x11-libs/gtk+-2.2.0-r1
		>=gnome-base/gconf-2
		>=x11-libs/startup-notification-0.4
		!x11-wm/metacity"

DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.12.0
		>=dev-util/intltool-0.29"

G2CONF="${G2CONF} $(use_enable xinerama)"

DOCS="AUTHORS Changelog COPYING HACKING INSTALL NEWS README*"
