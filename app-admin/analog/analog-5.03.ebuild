# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/analog/analog-5.03.ebuild,v 1.2 2001/10/10 20:18:27 woodchip Exp $

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
	insinto /usr/share/doc/${PF}/html_manual ; doins docs/favicon.ico docs/*.{html,gif,css}
	insinto /usr/share/doc/${PF}/cgi_interface ; doins anlgform.html anlgform.pl
	insinto /usr/share/doc/${PF}/sample_configs ; doins examples/*
	insinto /usr/share/doc/${PF}/report_images ; doins images/*
	cp -a how-to ${D}/usr/share/doc/${PF}

}
