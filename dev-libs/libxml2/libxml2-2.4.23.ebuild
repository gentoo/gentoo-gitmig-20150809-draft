# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxml2/libxml2-2.4.23.ebuild,v 1.2 2002/07/17 23:04:41 lostlogic Exp $

S=${WORKDIR}/${P}
DESCRIPTION="libxml2"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/libxml/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=sys-libs/ncurses-5.2
	>=sys-libs/readline-4.1
	>=sys-libs/zlib-1.1.4" 


src_compile() {
	# Fix .la files of python site packages
	libtoolize --copy --force

	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --mandir=/usr/share/man \
		    --sysconfdir=/etc \
		    --with-zlib  || die

	MAKEOPTS="-j1" emake || die
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

