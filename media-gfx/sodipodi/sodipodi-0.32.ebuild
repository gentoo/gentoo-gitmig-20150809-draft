# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sodipodi/sodipodi-0.32.ebuild,v 1.1 2003/06/21 11:10:56 liquidx Exp $

inherit gnome2

DESCRIPTION="vector-based drawing program for GNOME"
HOMEPAGE="http://sodipodi.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE="gnome mmx"

RDEPEND=">=x11-libs/gtk+-2.2.1
	>=media-libs/libart_lgpl-2.3.10
	>=dev-libs/libxml2-2.4.24
	virtual/xft
	dev-libs/popt
	sys-libs/zlib
	media-libs/libpng
	gnome? ( =gnome-base/libgnomeprintui-1.116* )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	>=dev-util/intltool-0.22"

G2CONF="${G2CONF} `use_enable mmx`"
G2CONF="${G2CONF} `use_enable gnome gnome-print`"

# FIXME : xft doesnt actually seem to work 
G2CONF="${G2CONF} --with-xft --with-popt"

DOCS="AUTHORS COPYING ChangeLog HACKING NEWS README TODO"

SCROLLKEEPER_UPDATE="0"
