# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sodipodi/sodipodi-0.31.1-r1.ebuild,v 1.2 2003/03/30 22:24:27 liquidx Exp $

inherit gnome2

DESCRIPTION="Sodipodi is a vector-based drawing program for GNOME."
HOMEPAGE="http://sodipodi.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ~sparc ~alpha ~ppc"
IUSE="gnome mmx"

RDEPEND=">=x11-libs/gtk+-2.2.1
	>=media-libs/libart_lgpl-2.3.10
	>=dev-libs/libxml2-2.4.24
	virtual/xft
	dev-libs/popt
	sys-libs/zlib
	media-libs/libpng
	gnome? ( =gnome-base/libgnomeprintui-2.2* )"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	>=dev-util/intltool-0.22"

use mmx \
	&& G2CONF="--enable-mmx ${G2CONF}" \
	|| G2CONF="--disable-mmx ${G2CONF}"
use gnome \
	&& G2CONF="--with-gnome-print ${G2CONF}" \
	|| G2CONF="--without-gnome-print ${G2CONF}"

# FIXME : xft doesnt actually seem to work 
G2CONF="${G2CONF} --with-xft --with-popt"

DOCS="AUTHORS COPYING ChangeLog HACKING NEWS README TODO"

SCROLLKEEPER_UPDATE="0"
