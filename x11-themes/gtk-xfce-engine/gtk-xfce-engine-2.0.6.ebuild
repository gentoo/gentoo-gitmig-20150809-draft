# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-xfce-engine/gtk-xfce-engine-2.0.6.ebuild,v 1.2 2002/10/04 06:47:27 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gtk+-2 engine, xfce"
SRC_URI="mirror://sourceforge/xfce/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/xfce/"

DEPEND=">=x11-libs/gtk+-2.0.5"
RDEPEND="$DEPEND"

LICENSE="GPL-2"
SLOT="0" 
KEYWORDS="*"

src_compile() {
	econf
	emake || die
}

src_install () {
	einstall
	dodoc AUTHORS COPYING INSTALL NEWS README TODO
}
