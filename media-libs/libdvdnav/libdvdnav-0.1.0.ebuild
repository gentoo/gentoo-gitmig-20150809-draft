# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Arcady Genkin <agenkin@thpoon.com>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdnav/libdvdnav-0.1.0.ebuild,v 1.2 2002/05/01 03:08:27 agenkin Exp $

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="http://sourceforge.net/projects/dvd/"

SRC_URI="http://prdownloads.sourceforge.net/dvd/${P}.tar.gz"
S=${WORKDIR}/${P}

LICENSE="GPL"

DEPEND="media-libs/libdvdread"

src_compile() {

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING INSTALL NEWS README
}
