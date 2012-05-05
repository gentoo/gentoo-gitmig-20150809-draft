# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/e16menuedit2/e16menuedit2-0.0.3.ebuild,v 1.10 2012/05/05 04:53:52 jdhore Exp $

inherit gnome2 eutils

DESCRIPTION="Menu editor for enlightenment DR16 written in GTK2"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 arm ~ppc sh sparc x86"
IUSE=""

RDEPEND=">=x11-wm/enlightenment-0.16
	>=gnome-base/libglade-2.4
	=x11-libs/gtk+-2*"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_unpack() {
	gnome2_src_unpack
	epatch "${FILESDIR}"/${P}-no-docs.patch
	sed -i '1i#include <glib/gstdio.h>' src/e16menuedit2.c
}

DOCS="AUTHORS ChangeLog NEWS README TODO"
