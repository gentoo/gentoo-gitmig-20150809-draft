# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Grant Goodyear <grant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/xclip/xclip-0.08.ebuild,v 1.1 2002/04/27 07:41:31 seemant Exp $

S=${WORKDIR}/xclip
DESCRIPTION="Command-line utility to read data from standard in and
 place it in an X selection for pasting into X applications."
SRC_URI="http://people.debian.org/~kims/xclip/${P}.tar.gz"
HOMEPAGE="http://people.debian.org/~kims/xclip"

DEPEND="virtual/x11"

src_compile() {

	xmkmf || die
	make || die

}

src_install () {

	make DESTDIR=${D} install || die
	make DESTDIR=${D} install.man || die
	dodoc README INSTALL CHANGES

}
