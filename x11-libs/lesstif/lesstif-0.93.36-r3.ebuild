# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/lesstif/lesstif-0.93.36-r3.ebuild,v 1.4 2003/09/06 10:49:12 lanius Exp $

DESCRIPTION="An OSF/Motif(R) clone"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.lesstif.org/"

LICENSE="LGPL-2"
KEYWORDS="~x86 ~ppc ~sparc"
SLOT="0"

PROVIDE="virtual/motif"

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
		--prefix=/usr/X11R6 \
		--sysconfdir=/etc/X11 \
		--libdir=/usr/X11R6/lib \
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
	emake prefix=${D}/usr/X11R6 \
		exec_prefix=${D}/usr/X11R6 \
		libdir=${D}/usr/X11R6/lib \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dosym /usr/X11R6/lib/libXm.so.2.0.1 /usr/X11R6/lib/libXm.so.1

	# This comes from x11-base/xfree!
	rm -f ${D}/usr/lib/X11/config/host.def

	dodir /usr/share
	mv ${D}/usr/X11R6/man ${D}/usr/share/
	dodir /usr/share/doc/${P}
	mv ${D}/usr/X11R6/LessTif/*  ${D}/usr/share/doc/${P}/
	# The LessTif directory should be empty now.
	rmdir ${D}/usr/X11R6/LessTif || die
}

pkg_postrm() {
	# Handle if updating removed host.def
	if [ ! -f ${ROOT}/usr/lib/X11/config/host.def \
	     -a -d ${ROOT}/usr/lib/X11/config ]
	then
		touch ${ROOT}/usr/lib/X11/config/host.def
	fi
}
