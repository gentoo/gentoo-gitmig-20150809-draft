# $Header: /var/cvsroot/gentoo-x86/x11-libs/lesstif/lesstif-0.93.36-r2.ebuild,v 1.2 2003/01/05 00:55:10 aliz Exp $
# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

S="${WORKDIR}/${P}"
DESCRIPTION="An OSF/Motif(R) clone."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.lesstif.org/"
PROVIDE="virtual/motif"
LICENSE="LGPL"
KEYWORDS="~x86 ~ppc"
SLOT="0"

DEPEND="virtual/x11"

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
		--enable-build-12 \
		--enable-build-20 \
		--enable-build-21 \
		--with-x || die "./configure failed"
	
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	
	emake prefix=${D}/usr \
		exec_prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die	
	
	dosym /usr/lib/libXm.so.2.0.1 /usr/lib/libXm.so.1

	# This comes from x11-base/xfree!
	rm -f ${D}/usr/lib/X11/config/host.def
	
	dodir /usr/share
	mv ${D}/usr/man ${D}/usr/share/
	dodir /usr/share/doc/${P}
	mv ${D}/usr/LessTif/*  ${D}/usr/share/doc/${P}/
	# The LessTif directory should be empty now.
	rmdir ${D}/usr/LessTif || die
}

pkg_postrm() {
	# Handle if updating removed host.def
	if [ ! -f ${ROOT}/usr/lib/X11/config/host.def \
	     -a -d ${ROOT}/usr/lib/X11/config ]
	then
		touch ${ROOT}/usr/lib/X11/config/host.def
	fi
}

