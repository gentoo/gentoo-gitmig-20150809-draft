# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libzvt/libzvt-2.0.1-r1.ebuild,v 1.9 2004/07/15 00:47:50 agriffis Exp $

inherit gnome2

IUSE=""
DESCRIPTION="Zed's Virtual Terminal Library"
SRC_URI="mirror://gnome/2.0.0/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86 ppc sparc alpha"

RDEPEND=">=dev-libs/glib-2.0.3
	>=x11-libs/gtk+-2.0.5
	>=media-libs/libart_lgpl-2.3.9"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"



DOCS="ABOUT* AUTHORS COPY* ChangeLog INSTALL NEWS README"
