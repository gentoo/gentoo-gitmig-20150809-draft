# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/zvbi/zvbi-0.2.1.ebuild,v 1.2 2002/07/23 00:49:50 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="VBI Decoding Library for Zapping"
SRC_URI="mirror://sourceforge/zapping/${P}.tar.bz2"
HOMEPAGE="http://zapping.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/x11 sys-devel/gettext"

src_compile() {
	
	econf ${myconf} || die
	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
