# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Desktop Team <desktop@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sane-backends/sane-backends-1.0.8.ebuild,v 1.1 2002/06/22 08:40:51 rphillips Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Scanner Access Now Easy - Backends"
SRC_URI="ftp://ftp.mostang.com/pub/sane/sane-$PV/$P.tar.gz"
HOMEPAGE="http://www.mostang.com/sane/"

DEPEND=">=media-libs/jpeg-6b"

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/linux_sg3_err.h ${S}/sanei

	#only generate the .ps and not the fonts 
	cp ${S}/doc/Makefile.in ${S}/doc/Makefile.in.orig
	sed -e 's:dvips sane.dvi -o sane.ps:dvips sane.dvi -o -M0 sane.ps:' \
		${S}/doc/Makefile.in.orig > ${S}/doc/Makefile.in
}

src_compile() {
	./configure --prefix=/usr \
		--sysconfdir=/etc \
		--mandir=/usr/share/man \
		--host=${CHOST} || die
	make || die
}

src_install () {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		mandir=${D}/usr/share/man \
		docdir=${D}/usr/share/doc/${PF} \
		install || die

	docinto backend
	cd backend
	dodoc GUIDE *.README *.BUGS *.CHANGES *.FAQ *.TODO
}


pkg_postinst() {
	
	echo "SANE_CONFIG_DIR=/etc/sane.d" > /etc/env.d/30sane

}
