# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/shorten/shorten-3.3.ebuild,v 1.5 2002/09/21 02:12:15 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Open source, popular and fast lossless audio compressor"
SRC_URI="http://shnutils.etree.org/shorten/source/${P}.tar.gz"
DEPEND="virtual/glibc"
HOMEPAGE="http://shnutils.etree.org/shorten/"

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

