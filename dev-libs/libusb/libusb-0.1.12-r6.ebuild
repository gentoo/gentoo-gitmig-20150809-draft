# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libusb/libusb-0.1.12-r6.ebuild,v 1.2 2011/12/06 19:33:32 robbat2 Exp $

inherit eutils libtool autotools toolchain-funcs

DESCRIPTION="Userspace access to USB devices"
HOMEPAGE="http://libusb.sourceforge.net/"
SRC_URI="mirror://sourceforge/libusb/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="debug doc nocxx"
RESTRICT="test"

RDEPEND="!dev-libs/libusb-compat"
DEPEND="${RDEPEND}
	doc? ( app-text/openjade
	app-text/docbook-dsssl-stylesheets
	app-text/docbook-sgml-utils
	~app-text/docbook-sgml-dtd-4.2 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's:-Werror::' Makefile.am
	sed -i 's:AC_LANG_CPLUSPLUS:AC_PROG_CXX:' configure.in #213800
	epatch "${FILESDIR}"/${PV}-fbsd.patch
	use nocxx && epatch "${FILESDIR}"/${PN}-0.1.12-nocpp.patch
	epatch "${FILESDIR}"/${PN}-0.1.12-no-infinite-bulk.patch
	epatch "${FILESDIR}"/${PN}-0.1-ansi.patch # 273752
	eautoreconf
	elibtoolize
}

src_compile() {
	econf \
		$(use_enable debug debug all) \
		$(use_enable doc build-docs)
	emake || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS NEWS README
	use doc && dohtml doc/html/*.html

	gen_usr_ldscript -a usb
	use nocxx && rm -f "${D}"/usr/include/usbpp.h
}
