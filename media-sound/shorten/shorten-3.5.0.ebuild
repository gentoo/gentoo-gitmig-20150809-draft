# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/shorten/shorten-3.5.0.ebuild,v 1.1 2003/02/05 06:27:12 vapier Exp $

DESCRIPTION="fast, low complexity waveform coder (i.e. audio compressor)"
HOMEPAGE="http://etree.org/shnutils/shorten/"
SRC_URI="http://etree.org/shnutils/shorten/source/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"

src_compile() {                           
	econf || die
	make || die
}

src_install() {                               
	make DESTDIR=${D} install || die
	dodoc AUTHORS LICENSE ChangeLog NEWS README
}
