# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/id3v2/id3v2-0.1.9-r1.ebuild,v 1.10 2005/04/01 21:12:17 hansmi Exp $

inherit eutils

IUSE=""

DESCRIPTION="A command line editor for id3v2 tags."
HOMEPAGE="http://id3v2.sourceforge.net/"
SRC_URI="mirror://sourceforge/id3v2/${P}.tar.gz"
RESTRICT="nomirror"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc ~alpha ~hppa amd64"

DEPEND="media-libs/id3lib"

src_unpack()
{
	unpack ${A} && cd ${S} || die "unpack failed"

	# The tarball came with a compiled binary. ;^)
	make clean

	# Use our own CXXFLAGS
	sed -i -e "/g++/ s|-g|${CXXFLAGS}|" Makefile || die "sed failed"

	# Fix segfault on alpha (and probably other architectures)
	epatch ${FILESDIR}/id3v2-0.1.9-alpha.patch
}

src_compile()
{
	emake || die
}

src_install()
{
	dobin id3v2
	doman id3v2.1
	dodoc COPYING INSTALL README
}
