# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/librsvg/librsvg-2.1.1.ebuild,v 1.4 2002/12/03 14:37:48 nall Exp $

inherit gnome2 debug

S=${WORKDIR}/${P}
DESCRIPTION="rendering svg library"
HOMEPAGE="http://www.gnome.org/"
SLOT="2"
KEYWORDS="x86 ~ppc"
LICENSE="GPL-2 LGPL-2.1"

RDEPEND=">=dev-libs/glib-2.0.4
	=x11-libs/gtk+-2.1*
	>=media-libs/libart_lgpl-2.3.10
	>=dev-libs/libxml2-2.4.24
	=x11-libs/pango-1.1*"

DEPEND="${RDEPEND} 
	>=dev-util/pkgconfig-0.12.0"
	
G2CONF="${G2CONF} --enable-platform-gnome-2"

DOCS="AUTHORS ChangeLog COPYIN* README INSTALL NEWS TODO"


