# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tre/tre-0.7.2.ebuild,v 1.5 2007/12/12 16:26:14 pva Exp $

IUSE="nls static"

DESCRIPTION="Lightweight, robust, and efficient POSIX compliant regexp matching library."
HOMEPAGE="http://laurikari.net/tre/index.html"
SRC_URI="http://laurikari.net/tre/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ~x86"

DEPEND="virtual/libc
	sys-apps/gawk
	sys-apps/grep
	sys-apps/sed
	sys-devel/gettext
	sys-devel/libtool
	sys-devel/gcc
	dev-util/pkgconfig"

RDEPEND="virtual/libc
	!app-misc/glimpse
	!app-text/agrep"

src_compile() {
	# Build TRE library.
	econf \
		`use_enable nls` \
		`use_enable static` \
		--enable-agrep \
		--enable-system-abi \
		--disable-profile \
		--disable-debug || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dohtml doc/tre-api.html doc/tre-syntax.html
}

pkg_postinst() {
	ewarn ""
	ewarn "app-misc/glimpse, app-text/agrep and this package all provide agrep."
	ewarn "If this causes a problem please file bug report on bugs.gentoo.org."
	ewarn ""
}
