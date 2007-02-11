# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/expocity/expocity-2.6.2.1.ebuild,v 1.7 2007/02/11 00:56:09 troll Exp $

inherit gnome2

DESCRIPTION="metacity app for switching between apps; similar to Expose on OSX"

HOMEPAGE="http://www.pycage.de/#expocity"
MY_P=${P/.1/-1}
SRC_URI="http://www.pycage.de/download/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
IUSE="xinerama"
KEYWORDS="~amd64 ppc x86"

# All needed X11 related DEPEND atoms are in gtk+
RDEPEND=">=x11-libs/pango-1.2
		>=x11-libs/gtk+-2.2.0-r1
		>=gnome-base/gconf-2
		>=x11-libs/startup-notification-0.4
		!x11-wm/metacity"

DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.12.0
		>=dev-util/intltool-0.29"

S=${WORKDIR}/${MY_P}
G2CONF="${G2CONF} $(use_enable xinerama)"

DOCS="AUTHORS Changelog HACKING NEWS README*"
