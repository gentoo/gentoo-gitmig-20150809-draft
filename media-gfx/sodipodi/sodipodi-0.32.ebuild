# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sodipodi/sodipodi-0.32.ebuild,v 1.4 2004/01/26 00:30:10 vapier Exp $

inherit gnome2

DESCRIPTION="vector-based drawing program for GNOME"
HOMEPAGE="http://sodipodi.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha"
IUSE="gnome mmx"

RDEPEND=">=x11-libs/gtk+-2.2.1
	>=media-libs/libart_lgpl-2.3.10
	>=dev-libs/libxml2-2.4.24
	virtual/xft
	dev-libs/popt
	sys-libs/zlib
	media-libs/libpng
	gnome? ( >=gnome-base/libgnomeprintui-2.2 )"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	>=dev-util/intltool-0.22"

G2CONF="${G2CONF} `use_enable mmx` `use_with gnome gnome-print`"
G2CONF="${G2CONF} --with-xft --with-popt"

DOCS="AUTHORS ChangeLog HACKING NEWS README TODO"
