# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/glitter/glitter-1.0.ebuild,v 1.2 2002/07/17 02:39:13 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Glitter - a binary downloader for newsgroups"
HOMEPAGE="http://www.mews.org.uk/glitter/"
SRC_URI="http://www.mews.org.uk/glitter/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="gnome-base/gnome-libs"

src_compile() {

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--sysconfdir=/etc || die "./configure failed"
	
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
