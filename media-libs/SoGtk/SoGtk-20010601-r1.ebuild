# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/SoGtk/SoGtk-20010601-r1.ebuild,v 1.19 2005/07/29 20:19:14 vanquirius Exp $

inherit eutils

DESCRIPTION="A Gtk Interface for coin"
HOMEPAGE="http://www.coin3d.org"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE="doc nls"

DEPEND="virtual/x11
	<x11-libs/gtkglarea-1.99.0
	media-libs/coin
	=sys-apps/sed-4*
	nls? ( sys-devel/gettext )
	doc? ( app-doc/doxygen )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}; cd ${S}
	epatch ${FILESDIR}/${P}-string.patch
}

src_compile() {

	./bootstrap --add

	local myconf

	if ! use nls
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
