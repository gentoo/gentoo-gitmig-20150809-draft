# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/gmfsk/gmfsk-0.6.ebuild,v 1.1 2004/07/24 04:39:21 killsoft Exp $

inherit gnome2

DESCRIPTION="Gnome MFSK, RTTY, THROB, PSK31, MT63 and HELLSCHREIBER terminal"
HOMEPAGE="http://gmfsk.connect.fi/index.html"
SRC_URI="http://he.fi/pub/ham/unix/linux/hfmodems/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND="virtual/libc
	virtual/x11
	gnome-base/gnome-libs
	>=gnome-base/libgnomeui-2.0
	gnome-extra/yelp
	>=media-libs/hamlib-1.2.0
	<dev-libs/fftw-3"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.3.5
	dev-util/pkgconfig
	>=gnome-base/gconf-2.6"

G2CONF="${G2CONF} --enable-hamlib"

