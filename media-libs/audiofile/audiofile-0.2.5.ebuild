# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/audiofile/audiofile-0.2.5.ebuild,v 1.5 2004/02/18 13:48:29 agriffis Exp $

inherit libtool gnuconfig

S=${WORKDIR}/${P}
DESCRIPTION="An elegant API for accessing audio files"
SRC_URI="http://www.68k.org/~michael/audiofile/${P}.tar.gz"
HOMEPAGE="http://www.68k.org/~michael/audiofile/"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc ~alpha hppa ~amd64 ~mips ~ia64"

src_compile() {

	# Allows configure to detect mipslinux systems
	use mips && gnuconfig_update

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
