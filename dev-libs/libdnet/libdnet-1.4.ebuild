# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Paul Belt <gaarde@yahoo.com>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdnet/libdnet-1.4.ebuild,v 1.1 2002/05/01 06:06:37 rphillips Exp $

DESCRIPTION="libdnet provides a simplified, portable interface to several low-level networking routines."
SRC_URI="http://prdownloads.sourceforge.net/libdnet/${P}.tar.gz"
HOMEPAGE="http://libdnet.sourceforge.net/"

src_compile() {
	econf
	emake || die
}

src_install () {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
	dodoc COPYING.LIB ChangeLog VERSION README
}

