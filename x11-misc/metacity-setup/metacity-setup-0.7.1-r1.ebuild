# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/metacity-setup/metacity-setup-0.7.1-r1.ebuild,v 1.10 2003/09/05 23:18:18 msterret Exp $

inherit gnome2

DESCRIPTION="a setup program for metacity"
HOMEPAGE="http://plastercast.tzo.com/~plastercast/Projects/"
SRC_URI="mirror:///sourceforge/metacity-setup/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc"

RDEPEND=">=x11-wm/metacity-2.4
	>=x11-libs/gtk+-2
	>=dev-libs/glib-2
	>=gnome-base/libgnomeui-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS COPYING  ChangeLog INSTALL NEWS README"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/metacity-setup-0.7.1-themedir.patch || die
}

