# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/audiofile/audiofile-0.2.4.ebuild,v 1.8 2004/07/14 18:49:48 agriffis Exp $

inherit libtool gnuconfig

DESCRIPTION="An elegant API for accessing audio files"
SRC_URI="http://www.68k.org/~michael/audiofile/${P}.tar.gz"
HOMEPAGE="http://www.68k.org/~michael/audiofile/"

DEPEND="virtual/libc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc alpha hppa ~amd64 ~mips ia64"
IUSE=""

src_compile() {

	# Allows configure to detect mipslinux systems
	gnuconfig_update

	elibtoolize

	local myconf

	myconf=" --enable-largefile"

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die

	dodoc ACKNOWLEDGEMENTS AUTHORS COPYING* ChangeLog README TODO
	dodoc NEWS NOTES
}
