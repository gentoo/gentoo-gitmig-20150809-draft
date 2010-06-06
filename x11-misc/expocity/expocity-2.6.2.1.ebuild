# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/expocity/expocity-2.6.2.1.ebuild,v 1.9 2010/06/06 09:35:46 ssuominen Exp $

EAPI=2
inherit gnome2

MY_P=${P/.1/-1}

DESCRIPTION="metacity app for switching between apps; similar to Expose on OSX"
HOMEPAGE="http://www.pycage.de/#expocity"
SRC_URI="http://www.pycage.de/download/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="xinerama"

RDEPEND=">=x11-libs/pango-1.2[X]
	x11-libs/gtk+:2
	>=gnome-base/gconf-2
	>=x11-libs/startup-notification-0.4
	!x11-wm/metacity"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12
	>=dev-util/intltool-0.29"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable xinerama)"
	DOCS="AUTHORS ChangeLog HACKING NEWS README*"
}
