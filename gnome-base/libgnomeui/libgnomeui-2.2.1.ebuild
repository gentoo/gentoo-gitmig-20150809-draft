# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomeui/libgnomeui-2.2.1.ebuild,v 1.1 2003/06/05 11:13:33 foser Exp $

inherit gnome2

DESCRIPTION="User interface part of libgnome"
HOMEPAGE="http://www.gnome.org/"
IUSE="doc"

SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc"
LICENSE="GPL-2 LGPL-2" 

RDEPEND=">=x11-libs/pango-1.1.2
	>=dev-lang/perl-5.002
	>=dev-libs/popt-1.5
	>=media-sound/esound-0.2.26
	>=media-libs/audiofile-0.2.3
	>=gnome-base/libbonoboui-2
	>=gnome-base/gconf-1.2
	>=gnome-base/libgnome-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnomecanvas-2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.6 )"

PDEPEND="x11-themes/gnome-themes
	x11-themes/gnome-icon-theme"


DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"
