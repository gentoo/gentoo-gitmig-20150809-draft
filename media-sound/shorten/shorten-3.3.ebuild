# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/shorten/shorten-3.3.ebuild,v 1.3 2002/07/21 13:50:33 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Open source, popular and fast lossless audio compressor"
SRC_URI="http://shnutils.etree.org/misc/${P}.tar.gz"
DEPEND="virtual/glibc"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"

src_compile() {                           
	econf || die
	make || die
}

src_install() {                               
	make DESTDIR=${D} install || die
	dodoc AUTHORS LICENSE ChangeLog NEWS README
}

