# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/id3v2/id3v2-0.1.7.ebuild,v 1.1 2002/05/22 20:24:55 agenkin Exp $

DESCRIPTION="A command line editor for id3v2 tags."
HOMEPAGE="http://id3v2.sourceforge.net/"

DEPEND="media-libs/id3lib"

SRC_URI="http://unc.dl.sourceforge.net/sourceforge/id3v2/${P}.tar.gz"
S=${WORKDIR}/${P}

src_unpack()
{
	unpack "${A}"
        cd "${S}"
        # The tarball came with a compiled binary. ;^)
        make clean
        sed -e "/g++/ s|-g|${CFLAGS}|" < Makefile > Makefile.hacked
        mv Makefile.hacked Makefile
}

src_compile()
{
	emake || die
}

src_install ()
{
        dobin id3v2
        doman id3v2.1
        dodoc COPYING INSTALL README
}
