# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/audiofile/audiofile-0.2.6-r1.ebuild,v 1.1 2004/04/05 07:20:53 eradicator Exp $

inherit libtool gnuconfig eutils

DESCRIPTION="An elegant API for accessing audio files"
HOMEPAGE="http://www.68k.org/~michael/audiofile/"
SRC_URI="http://www.68k.org/~michael/audiofile/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha hppa ~amd64 ~mips ~ia64"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	cd ${S}/sfcommands
	epatch ${FILESDIR}/sfconvert-eradicator.patch

	cd ${S}
	# Allows configure to detect mipslinux systems
	use mips && gnuconfig_update

	elibtoolize
}

src_compile() {
	econf --enable-largefile || die
	emake || die
}

src_install() {
#	einstall || die
	make DESTDIR=${D} install || die
	dodoc ACKNOWLEDGEMENTS AUTHORS ChangeLog README TODO NEWS NOTES
}
