# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/analog/analog-5.03.ebuild,v 1.1 2001/10/01 00:39:48 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The most popular logfile analyser in the world"
SRC_URI="http://www.analog.cx/${P}.tar.gz"
HOMEPAGE="http://www.analog.cx/"

DEPEND="virtual/glibc
        >=dev-libs/libpcre-3.4
	>=media-libs/libgd-1.8.3
	>=sys-libs/zlib-1.1.3"

src_unpack() {
	unpack ${A} ; cd ${S}
	mv src/Makefile src/Makefile.orig
	sed -e "s/CFLAGS = -O2  /CFLAGS = ${CFLAGS}/" \
	    -e "s/DEFS =  /DEFS = -DHAVE_GD -DHAVE_PCRE/" \
	    -e "s/LIBS = -lm/LIBS = -lgd -lpng -ljpeg -lz -lpcre -lm/" \
	    src/Makefile.orig > src/Makefile
}

src_compile() {
	cd src ; emake ; assert "couldnt compile :("
}

src_install () {
	dobin analog ; newman analog.man analog.1

	dodoc README.txt Licence.txt analog.cfg

	docinto html_manual
	# dont want these gzipped
	cp docs/favicon.ico docs/*.{html,gif,css} ${D}/usr/share/doc/${P}/html_manual

	docinto cgi_interface
	dodoc anlgform.html anlgform.pl

	docinto sample_configs
	dodoc examples/*

	# dont want these gzipped
	cp -a how-to ${D}/usr/share/doc/${P}

	docinto report_images
	# dont want these gzipped
	cp images/* ${D}/usr/share/doc/${P}/report_images
}
