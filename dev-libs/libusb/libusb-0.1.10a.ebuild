# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libusb/libusb-0.1.10a.ebuild,v 1.19 2006/09/02 11:08:30 liquidx Exp $

inherit eutils libtool autotools

DESCRIPTION="Userspace access to USB devices"
HOMEPAGE="http://libusb.sourceforge.net/"
SRC_URI="mirror://sourceforge/libusb/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ~ppc-macos ppc64 s390 sh sparc x86"
IUSE="debug doc"

RDEPEND=""

DEPEND="sys-devel/libtool
	doc? ( app-text/openjade
		app-text/docbook-sgml-utils
		~app-text/docbook-sgml-dtd-4.2 )"

src_unpack(){
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PV}-fbsd.patch
	sed -i -e 's:-Werror::' Makefile.am
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
	make DESTDIR=${D} install || die
	dodoc AUTHORS NEWS README || die
	if use doc; then
		dohtml doc/html/*.html || die
	fi
}

src_test() {
	return
}
