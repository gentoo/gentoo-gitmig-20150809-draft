# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/SoGtk/SoGtk-20010601-r1.ebuild,v 1.23 2009/08/21 20:13:30 ssuominen Exp $

EAPI=2
inherit autotools eutils multilib

DESCRIPTION="A Gtk Interface for coin"
HOMEPAGE="http://www.coin3d.org"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE="doc nls"

RDEPEND="media-libs/coin
	<x11-libs/gtkglarea-1.99.0"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	doc? ( app-doc/doxygen )"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-string.patch
	eautoreconf
}

src_configure() {
	local myconf

	if ! use nls
	then
		myconf="${myconf} --disable-nls"
		touch intl/libgettext.h
	fi
	use doc && myconf="${myconf} --with-html --with-man"

	econf \
		--with-x \
		${myconf}

	sed -i "s:ENABLE_NLS 1:ENABLE_NLS 0:" config.h
}

src_install () {
	einstall \
		bindir="${D}/usr/bin" \
		includedir="${D}/usr/include" \
		libdir="${D}/usr/$(get_libdir)" || die "einstall failed"

	dodoc AUTHORS ChangeLog* NEWS README*
	docinto txt
	dodoc docs/*
}
