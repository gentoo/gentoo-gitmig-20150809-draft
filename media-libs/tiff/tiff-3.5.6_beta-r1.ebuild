# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/tiff/tiff-3.5.6_beta-r1.ebuild,v 1.1 2001/11/14 16:39:12 hallski Exp $

P=${PN}-v3.5.6-beta
S=${WORKDIR}/${P}
DESCRIPTION="libtiff"
SRC_URI="http://www.libtiff.org/${P}.tar.gz"
HOMEPAGE="http://www.libtiff.org/"

DEPEND=">=media-libs/jpeg-6b >=sys-libs/zlib-1.1.3-r2"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp ${FILESDIR}/config.site-${PV} config.site
	echo "DIR_HTML="${D}/usr/share/doc/${PF}/html"" >> config.site
}

src_compile() {
	./configure --noninteractive || die

	emake OPTIMIZER="${CFLAGS}" || die
}

src_install() {
	dodir /usr/{bin,lib,share/man,share/doc/${PF}/html}
	dodir /usr/share/doc/${PF}/html
	make INSTALL="/bin/sh ${S}/port/install.sh" install || die
	prepalldocs
    
	preplib /usr
	dodoc COPYRIGHT README TODO VERSION
}
