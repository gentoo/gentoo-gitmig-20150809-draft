# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-xfce-engine/gtk-xfce-engine-2.0.7.ebuild,v 1.1 2002/07/18 22:37:47 spider Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gtk+-2 engine, xfce"
SRC_URI="mirror://sourceforge/xfce/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/xfce/"

DEPEND=">=x11-libs/gtk+-2.0.5"
RDEPEND="$DEPEND"

LICENSE="GPL-2"
SLOT="0" 
KEYWORDS="x86"

src_compile() {
	econf
	emake || die
}

src_install () {
	einstall
	dodoc AUTHORS COPYING INSTALL NEWS README TODO
}
