# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libjsw/libjsw-1.5.0.ebuild,v 1.3 2004/02/11 15:17:28 dholm Exp $

DESCRIPTION="provide a uniform API and user configuration for joysticks and game controllers"
HOMEPAGE="http://wolfpack.twu.net/libjsw/"
SRC_URI="ftp://wolfpack.twu.net/users/wolfpack/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="gtk"

DEPEND="gtk? ( =x11-libs/gtk+-1.2* )"
#RDEPEND=""

src_compile() {
	cd ${S}/include
	cp xsw_ctype.h{,.old}
	sed -e "s:^extern.*isblank.*::" \
		xsw_ctype.h.old > xsw_ctype.h

	cd ${S}/libjsw
	sed -e "s:^CFLAGS.*:`grep ^CFLAGS Makefile.Linux` ${CFLAGS}:" \
		Makefile.Linux > Makefile
	make || die
	ln -sf libjsw.so.${PV} libjsw.so

	if [ `use gtk` ] ; then
		cd ${S}/jscalibrator
		sed -e "s:--cflags\`:--cflags\` ${CFLAGS} -I.:" \
		 -e "s:-ljsw:-ljsw -L../libjsw:" \
			Makefile.Linux > Makefile
		ln -s ../include/jsw.h
		make || die
	fi
}

src_install() {
	insinto /usr/include
	doins include/jsw.h

	dodoc AUTHORS README
	mv ${S}/jswdemos ${D}/usr/share/doc/${PF}/

	cd ${S}/libjsw
	dolib.so libjsw.so.${PV} || die
	dosym /usr/lib/libjsw.so.${PV} /usr/lib/libjsw.so
	doman man/*

	if [ `use gtk` ] ; then
		cd ${S}/jscalibrator
		dobin jscalibrator || die
		doman jscalibrator.1
		dohtml data/help/*
	fi
}
