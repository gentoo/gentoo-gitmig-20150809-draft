# $Header: /var/cvsroot/gentoo-x86/x11-libs/lesstif/lesstif-0.93.36.ebuild,v 1.4 2003/01/06 15:38:16 jmorgan Exp $
# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

DESCRIPTION="An OSF/Motif(R) clone."
HOMEPAGE="http://www.lesstif.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="LGPL"

DEPEND="virtual/x11"
PROVIDE="virtual/motif"
KEYWORDS="x86 sparc"
SLOT="0"

S="${WORKDIR}/${P}"

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
