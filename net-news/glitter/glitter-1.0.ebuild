# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/glitter/glitter-1.0.ebuild,v 1.1 2002/06/18 21:36:57 lostlogic Exp $

DESCRIPTION="Glitter - a binary downloader for newsgroups"
HOMEPAGE="http://www.mews.org.uk/glitter/"
LICENSE="GPL-2"

DEPEND="gnome-base/gnome-libs"
RDEPEND="${DEPEND}"

SLOT="0"

SRC_URI="http://www.mews.org.uk/glitter/${P}.tar.gz"

S=${WORKDIR}/${P}

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
