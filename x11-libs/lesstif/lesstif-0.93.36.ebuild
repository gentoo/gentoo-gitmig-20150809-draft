# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/lesstif/lesstif-0.93.36.ebuild,v 1.7 2003/09/06 10:49:12 lanius Exp $

DESCRIPTION="An OSF/Motif(R) clone"
HOMEPAGE="http://www.lesstif.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
KEYWORDS="x86 sparc"
SLOT="0"

DEPEND="virtual/x11"
PROVIDE="virtual/motif"

src_unpack() {
	unpack ${A}

	cd ${S}/scripts/autoconf
	sed -e "/^aclocaldir =/ a DESTDIR = ${D}" \
		Makefile.in > Makefile.in.hacked
	mv Makefile.in.hacked Makefile.in || die
}

src_compile() {
	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --infodir=/usr/share/info \
		    --mandir=/usr/share/man \
			--enable-static \
		    --with-x || die "./configure failed"
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	emake	prefix=${D}/usr \
		exec_prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dosym /usr/lib/libXm.so.2.0.1 /usr/lib/libXm.so.1

	dodir /usr/share
	mv ${D}/usr/man ${D}/usr/share/
	dodir /usr/share/doc/${P}
	mv ${D}/usr/LessTif/*  ${D}/usr/share/doc/${P}/
	# The LessTif directory should be empty now.
	rmdir ${D}/usr/LessTif || die
}
