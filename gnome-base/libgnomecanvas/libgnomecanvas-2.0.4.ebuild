# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomecanvas/libgnomecanvas-2.0.4.ebuild,v 1.10 2003/09/06 23:51:37 msterret Exp $

IUSE="doc"

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="the Gnome 2 Canvas library"
SRC_URI="mirror://gnome/2.0.1/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
LICENSE="GPL-2 LGPL-2.1"


RDEPEND=">=gnome-base/libglade-2.0.1
	>=x11-libs/gtk+-2.0.6
	>=dev-libs/glib-2.0.6
	>=x11-libs/pango-1.0.4
	>=media-libs/libart_lgpl-2.3.10
	>=dev-libs/libxslt-1.0.20
	>=media-libs/freetype-2.0.9
	>=sys-devel/gettext-0.10.40
	>=dev-lang/perl-5.6.1
	>=sys-apps/gawk-3.1.0
	>=sys-devel/bison-1.28-r3"


DEPEND=">=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9-r2 )
	${RDEPEND}"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"





