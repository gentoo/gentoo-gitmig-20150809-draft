# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libcroco/libcroco-0.4.0.ebuild,v 1.1 2004/02/09 01:00:09 spider Exp $

inherit gnome2

DESCRIPTION="A generic CSS parsing and manipulation toolkit"
HOMEPAGE="http://www.freespiders.org/projects/libcroco/"

IUSE="doc zlib"
SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2 LGPL-2"


RDEPEND=">=dev-libs/glib-2.0
	>=dev-libs/libxml2-2.4.23
	>=gnome-base/libgnomeui-2.0.4
	>=x11-libs/pango-1.0.4"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

# disable gimp plugin, now in gimp
G2CONF="${G2CONF}  --enable-seleng=no --enable-layeng=no"

DOCS="ABOUT-NLS AUTHORS ChangeLog COPYIN* HACKING README INSTALL NEWS TODO"
