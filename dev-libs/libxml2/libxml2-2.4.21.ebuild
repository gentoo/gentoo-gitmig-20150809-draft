# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org>,  Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxml2/libxml2-2.4.21.ebuild,v 1.1 2002/05/09 19:29:30 spider Exp $

S=${WORKDIR}/${P}
DESCRIPTION="libxml"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/libxml/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=sys-libs/ncurses-5.2
	>=sys-libs/readline-4.1
	>=sys-libs/zlib-1.1.4" 


src_compile() {
	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --mandir=/usr/share/man \
		    --sysconfdir=/etc \
		    --with-zlib  || die

	emake || die
}

src_install() {
	make DESTDIR=${D} \
		DOCS_DIR=/usr/share/doc/${PF}/python \
		EXAMPLE_DIR=/usr/share/doc/${PF}/python/example \
		BASE_DIR=/usr/share/doc \
		DOC_MODULE=${PF} \
		EXAMPLES_DIR=/usr/share/doc/${PF}/example \
		TARGET_DIR=/usr/share/doc/${PF}/html \
		install || die
	
	dodoc AUTHORS COPYING* ChangeLog NEWS README
}

