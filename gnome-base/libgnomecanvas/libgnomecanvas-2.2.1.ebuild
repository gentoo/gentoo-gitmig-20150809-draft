# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomecanvas/libgnomecanvas-2.2.1.ebuild,v 1.1 2003/05/19 22:42:30 foser Exp $

inherit gnome2

IUSE="doc"
S=${WORKDIR}/${P}
DESCRIPTION="the Gnome 2 Canvas library"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"
LICENSE="GPL-2 LGPL-2" 

RDEPEND=">=gnome-base/libglade-2
	>=x11-libs/gtk+-2.0.3
	>=x11-libs/pango-1.1.3
	>=media-libs/libart_lgpl-2.3.8"

DEPEND=">=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9-r2 )
	${RDEPEND}"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"
