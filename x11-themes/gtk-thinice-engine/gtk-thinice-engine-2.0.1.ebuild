# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-thinice-engine/gtk-thinice-engine-2.0.1.ebuild,v 1.5 2002/10/04 06:47:20 vapier Exp $

SLOT="0"
S=${WORKDIR}/${P}
DESCRIPTION="GTK theme engine for ThinICE"
SRC_URI="http://thinice.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://thinice.sourceforge.net"
KEYWORDS="x86"

DEPEND=">=x11-libs/gtk+-2.0.0"
RDEPEND=$DEPEND
LICENSE="GPL-2"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS COPYING INSTALL NEWS README TODO
}

