# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/zvbi/zvbi-0.2.1-r1.ebuild,v 1.1 2002/09/15 10:50:12 spider Exp $

S=${WORKDIR}/${P}
DESCRIPTION="VBI Decoding Library for Zapping"
SRC_URI="mirror://sourceforge/zapping/${P}.tar.bz2"
HOMEPAGE="http://zapping.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/x11 sys-devel/gettext"

src_compile() {
	
	econf ${myconf} || die
	cp doc/zdoc-scan doc/zdoc-scan.orig 
	sed -e 's:usr\/local\/share\/gtk-doc:usr\/share\/gtk-doc:' doc/zdoc-scan.orig > doc/zdoc-scan 
	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
