# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sodipodi/sodipodi-0.34.ebuild,v 1.10 2005/08/26 21:24:22 ranger Exp $

inherit gnome2 eutils

DESCRIPTION="vector-based drawing program for GNOME"
HOMEPAGE="http://sodipodi.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ppc ~ppc64 sparc x86"
IUSE="gnome mmx"

RDEPEND=">=x11-libs/gtk+-2.2.1
	>=media-libs/libart_lgpl-2.3.10
	>=dev-libs/libxml2-2.4.24
	virtual/xft
	media-libs/fontconfig
	dev-libs/popt
	sys-libs/zlib
	media-libs/libpng
	gnome? ( >=gnome-base/libgnomeprint-2.2
		>=gnome-base/libgnomeprintui-2.2 )"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	>=dev-util/intltool-0.22"

G2CONF="${G2CONF} `use_enable mmx` `use_with gnome gnome-print`"
G2CONF="${G2CONF} --with-xft --with-popt"
# disable experimental features for now
G2CONF="${G2CONF} --without-mlview --without-kde"

DOCS="AUTHORS ChangeLog HACKING NEWS README TODO"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/sodipodi-0.34.64bit.diff
}
