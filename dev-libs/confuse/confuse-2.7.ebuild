# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/confuse/confuse-2.7.ebuild,v 1.11 2012/08/20 03:17:01 ottxor Exp $

EAPI=3

DESCRIPTION="a configuration file parser library"
HOMEPAGE="http://www.nongnu.org/confuse/"
SRC_URI="mirror://nongnu/confuse/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~sparc-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="nls static-libs"

DEPEND="sys-devel/flex
	sys-devel/libtool
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"
RDEPEND="nls? ( virtual/libintl )"

src_configure() {
	# examples are normally compiled but not installed. They
	# fail during a mingw crosscompile.
	econf \
		--enable-shared \
		--disable-examples \
		$(use_enable nls) \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die

	doman doc/man/man3/*.3 || die
	dodoc AUTHORS NEWS README || die
	dohtml doc/html/* || die

	docinto examples
	dodoc examples/*.{c,conf} || die
}
