# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gnomesu/gnomesu-0.3.1.ebuild,v 1.3 2003/07/11 18:32:47 aliz Exp $

inherit gnome2

DESCRIPTION="GNOME2 interface to su, previously xsu and xsu2"
HOMEPAGE="http://sourceforge.net/projects/xsu/"
SRC_URI="mirror://sourceforge/xsu/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	>=dev-libs/glib-2
	>=gnome-base/libgnome-2	
	>=gnome-base/libgnomeui-2
	>=x11-libs/libzvt-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
  unpack ${A}
  epatch ${FILESDIR}/${P}-desktopfix.patch
}

src_install() {
	gnome2_src_install xsudocdir=${D}/usr/share/doc/${PF}
}
