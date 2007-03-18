# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnomeradio/gnomeradio-1.6.ebuild,v 1.4 2007/03/18 10:03:41 nixnut Exp $

inherit gnome2

DESCRIPTION="A GNOME2 radio tuner"
SRC_URI="http://www.wh-hms.uni-ulm.de/~mfcn/${PN}/packages/${P}.tar.gz"
HOMEPAGE="http://www.wh-hms.uni-ulm.de/~mfcn/gnomeradio/"

IUSE="lirc"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ~sparc ~x86"

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/gconf-1.2
	lirc? ( app-misc/lirc )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.21
	>=app-text/scrollkeeper-0.3.11"

DOCS="AUTHORS ChangeLog README* NEWS TODO"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable lirc)"
}
