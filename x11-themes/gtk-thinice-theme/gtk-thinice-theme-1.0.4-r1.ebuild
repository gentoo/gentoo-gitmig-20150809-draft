# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-thinice-theme/gtk-thinice-theme-1.0.4-r1.ebuild,v 1.2 2002/06/29 13:32:17 seemant Exp $


S=${WORKDIR}/${P}
DESCRIPTION="GTK ThinICE theme"
SRC_URI="http://thinice.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://thinice.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"

DEPEND="=x11-libs/gtk+-1.2*"

src_compile() {
    econf || die
    emake || die
}

src_install () {
    einstall || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
