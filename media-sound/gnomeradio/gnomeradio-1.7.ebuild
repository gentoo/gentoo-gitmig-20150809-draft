# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnomeradio/gnomeradio-1.7.ebuild,v 1.1 2007/08/21 20:54:53 drac Exp $

GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="A GNOME2 radio tuner"
HOMEPAGE="http://www.wh-hms.uni-ulm.de/~mfcn/gnomeradio"
SRC_URI="http://www.wh-hms.uni-ulm.de/~mfcn/${PN}/packages/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="lirc"

RDEPEND=">=gnome-extra/gnome-media-2.14
	>=media-libs/gst-plugins-base-0.10
	lirc? ( app-misc/lirc )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	app-text/scrollkeeper"

DOCS="AUTHORS ChangeLog NEWS README* TODO"

src_unpack() {
	gnome2_src_unpack
	epatch "${FILESDIR}"/${P}-trayicon.patch
	epatch "${FILESDIR}"/${P}-xml-description.patch
}
