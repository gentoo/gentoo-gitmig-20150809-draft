# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/inkscape/inkscape-0.38.1.ebuild,v 1.7 2005/02/28 18:05:17 corsair Exp $

inherit gnome2 eutils

DESCRIPTION="A SVG based generic vector-drawing program"
HOMEPAGE="http://www.inkscape.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE="gnome mmx"

RDEPEND=">=x11-libs/gtk+-2.2.4
	>=media-libs/libart_lgpl-2.3.16
	>=dev-libs/libxml2-2.6.4
	virtual/xft
	media-libs/fontconfig
	dev-libs/popt
	sys-libs/zlib
	media-libs/libpng
	=dev-libs/libsigc++-1.2*
	gnome? ( >=gnome-base/libgnomeprint-2.2
		>=gnome-base/libgnomeprintui-2.2 )"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

G2CONF="${G2CONF} --with-xft --with-popt"
use mmx || G2CONF="${G2CONF} --disable-mmx"
use gnome && G2CONF="${G2CONF} --with-gnome-print"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/string.patch
}

DOCS="AUTHORS COPYING ChangeLog HACKING NEWS README"
