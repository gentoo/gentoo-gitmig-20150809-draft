# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-thinice-theme/gtk-thinice-theme-1.0.4-r1.ebuild,v 1.4 2002/10/04 06:47:22 vapier Exp $


S=${WORKDIR}/${P}
DESCRIPTION="GTK ThinICE theme"
SRC_URI="http://thinice.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://thinice.sourceforge.net"
KEYWORDS="x86"

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
