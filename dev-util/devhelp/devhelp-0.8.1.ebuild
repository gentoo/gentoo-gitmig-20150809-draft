# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/devhelp/devhelp-0.8.1.ebuild,v 1.1 2004/02/14 16:31:59 liquidx Exp $

inherit gnome2

IUSE="zlib"

DESCRIPTION="Developer help browser"
HOMEPAGE="http://devhelp.codefactory.se/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2.2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/gnome-vfs-2.2
	=gnome-extra/libgtkhtml-2*
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS COPYING ChangeLog README NEWS TODO"

use zlib \
	&& G2CONF="${G2CONF} --with-zlib" \
	|| G2CONF="${G2CONF} --without-zlib"
