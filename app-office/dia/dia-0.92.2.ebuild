# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/dia/dia-0.92.2.ebuild,v 1.4 2004/02/09 07:44:02 absinthe Exp $

inherit gnome2

DESCRIPTION="Diagram/flowchart creation program"
HOMEPAGE="http://www.gnome.org/gnome-office/dia.shtml"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ppc ~sparc ~alpha amd64"
IUSE="gnome png python"

RDEPEND=">=x11-libs/gtk+-2
	>=x11-libs/pango-1.2.4
	>=dev-libs/libxml2-2.3.9
	>=dev-libs/libxslt-1
	>=media-libs/freetype-2.0.9
	>=sys-libs/zlib-1.1.4
	png? ( media-libs/libpng
		media-libs/libart_lgpl )
	gnome? ( >=gnome-base/libgnome-2.0
		>=gnome-base/libgnomeui-2.0 )
	python? ( >=dev-lang/python-2.0
		>=dev-python/pygtk-1.99 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21
	dev-util/pkgconfig"

G2CONF="${G2CONF} $(use_enable gnome) $(use_with python)"

DOCS="AUTHORS COPYING ChangeLog KNOWN_BUGS README RELEASE* NEWS THANKS TODO"
