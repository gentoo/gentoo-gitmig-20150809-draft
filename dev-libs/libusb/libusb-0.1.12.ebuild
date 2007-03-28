# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libusb/libusb-0.1.12.ebuild,v 1.18 2007/03/28 02:36:41 jer Exp $

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"
inherit eutils libtool autotools

DESCRIPTION="Userspace access to USB devices"
HOMEPAGE="http://libusb.sourceforge.net/"
SRC_URI="mirror://sourceforge/libusb/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="debug doc"
RESTRICT="test"

RDEPEND=""
DEPEND="doc? ( app-text/openjade
	app-text/docbook-dsssl-stylesheets
	app-text/docbook-sgml-utils
	~app-text/docbook-sgml-dtd-4.2 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's:-Werror::' Makefile.am
	epatch "${FILESDIR}"/${PV}-fbsd.patch
	eautoreconf
	elibtoolize
}

src_compile() {
	econf \
		$(use_enable debug debug all) \
		$(use_enable doc build-docs) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS NEWS README || die "dodoc failed"
	if use doc ; then
		dohtml doc/html/*.html || die "dohtml failed"
	fi
}
