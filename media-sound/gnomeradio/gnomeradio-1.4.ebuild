# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnomeradio/gnomeradio-1.4.ebuild,v 1.4 2003/08/27 02:19:33 obz Exp $ 

inherit gnome2

DESCRIPTION="A GNOME2 radio tuner"
SRC_URI="http://mfcn.ilo.de/gnomeradio/${P}.tar.gz"
HOMEPAGE="http://mfcn.ilo.de/gnomeradio/"

IUSE="lirc"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/gconf-1.2
	lirc? ( app-misc/lirc )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.21
	>=app-text/scrollkeeper-0.3.11"

DOCS="ABOUT-NLS AUTHORS ChangeLog COPYING README* INSTALL NEWS TODO"

use lirc \
	&& G2CONF="${G2CONF} --enable-lirc " \
	|| G2CONF="${G2CONF} --enable-lirc " 

