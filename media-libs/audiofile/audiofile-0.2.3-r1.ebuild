# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/audiofile/audiofile-0.2.3-r1.ebuild,v 1.23 2006/03/06 14:20:17 flameeyes Exp $

inherit libtool gnuconfig

DESCRIPTION="An elegant API for accessing audio files"
HOMEPAGE="http://www.68k.org/~michael/audiofile/"
SRC_URI="http://www.68k.org/~michael/audiofile/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ~mips ia64"
IUSE=""

src_compile() {

	# Allows configure to detect mipslinux systems
	gnuconfig_update

	elibtoolize

	econf || die
	emake || die
}

src_install() {
	einstall || die

	dodoc ACKNOWLEDGEMENTS AUTHORS COPYING* ChangeLog README TODO
	dodoc NEWS NOTES
}
