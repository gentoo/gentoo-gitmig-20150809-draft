# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/analog/analog-5.31.ebuild,v 1.8 2004/03/29 22:53:24 mr_bones_ Exp $

inherit eutils

DESCRIPTION="The most popular logfile analyser in the world"
HOMEPAGE="http://www.analog.cx/"
SRC_URI="http://www.analog.cx/${P}.tar.gz"
IUSE=""

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc"

DEPEND=">=dev-libs/libpcre-3.4
	>=media-libs/libgd-1.8.3
	sys-libs/zlib
	media-libs/jpeg"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	sed -i -e "s:^CFLAGS.*:CFLAGS = ${CFLAGS}:" \
		-e 's:^DEFS.*:DEFS = -DHAVE_GD -DHAVE_PCRE:' \
		-e 's:^LIBS.*:LIBS = -lgd -lpng -ljpeg -lz -lpcre -lm:' \
		src/Makefile
	epatch ${FILESDIR}/${PN}-5.1-gentoo.diff
}

src_compile() {
	make -C src || die
}

src_install() {
	dobin analog ; newman analog.man analog.1

	dodoc README.txt Licence.txt analog.cfg
	dohtml -a html,gif,css,ico docs/*
	docinto examples ; dodoc examples/*
	docinto cgi ; dodoc anlgform.pl
	cp -a how-to ${D}/usr/share/doc/${PF}

	insinto /usr/share/analog/images ; doins images/*
	insinto /usr/share/analog/lang ; doins lang/*
	dodir /var/log/analog
	dosym /usr/share/analog/images /var/log/analog/images
	insinto /etc/analog ; doins ${FILESDIR}/analog.cfg
}
