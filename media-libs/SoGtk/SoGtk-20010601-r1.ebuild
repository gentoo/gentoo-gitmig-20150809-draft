# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/SoGtk/SoGtk-20010601-r1.ebuild,v 1.14 2003/04/23 00:15:05 lostlogic Exp $

IUSE="nls doc"

S=${WORKDIR}/${PN}
DESCRIPTION="A Gtk Interface for coin"
SRC_URI="ftp://ftp.coin3d.org/pub/snapshots/${P}.tar.gz"
HOMEPAGE="http://www.coin3d.org"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc "

DEPEND="virtual/x11
	<x11-libs/gtkglarea-1.99.0
	media-libs/coin
	=sys-apps/sed-4*
	nls? ( sys-devel/gettext )
	doc? ( app-doc/doxygen )"

src_compile() {

	./bootstrap --add

	local myconf

	if [ -z "`use nls`" ]
	then
		myconf="${myconf} --disable-nls"
		touch intl/libgettext.h
	fi
	use doc && myconf="${myconf} --with-html --with-man"

	econf \
		--with-x \
		${myconf} || die

	sed -i "s:ENABLE_NLS 1:ENABLE_NLS 0:" config.h
	make || die
}

src_install () {
	
	einstall \
		bindir=${D}/usr/bin \
		includedir=${D}/usr/include \
		libdir=${D}/usr/lib || die
	
	cd ${S}
	dodoc AUTHORS COPYING ChangeLog* LICENSE* NEWS README*
	docinto txt
	dodoc docs/*
}
