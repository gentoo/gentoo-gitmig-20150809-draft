# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/libdsk/libdsk-1.1.0.ebuild,v 1.2 2003/11/14 20:03:42 seemant Exp $

DESCRIPTION="Disk emulation library"
HOMEPAGE="http://www.seasip.demon.co.uk/Unix/LibDsk/"
SRC_URI="http://www.seasip.demon.co.uk/Unix/LibDsk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="sys-libs/zlib
	app-arch/bzip2"

src_compile() {
	econf \
		--with-zlib \
		--with-bzlib \
		--enable-floppy \
		|| die
	emake || die "libdsk make failed!"
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc ChangeLog README TODO doc/libdsk.*
}
