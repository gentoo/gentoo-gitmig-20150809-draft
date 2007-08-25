# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tre/tre-0.7.4.ebuild,v 1.12 2007/08/25 17:31:15 beandog Exp $

IUSE="nls static"

DESCRIPTION="Lightweight, robust, and efficient POSIX compliant regexp matching library."
HOMEPAGE="http://laurikari.net/tre/index.html"
SRC_URI="http://laurikari.net/tre/${P}.tar.bz2"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86 ~x86-fbsd"

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
	emake DESTDIR=${D} install || die
	dodoc NEWS README THANKS TODO AUTHORS
	dohtml doc/*.{html,css}
}

pkg_postinst() {
	ewarn ""
	ewarn "app-misc/glimpse, app-text/agrep and this package all provide agrep."
	ewarn "If this causes any unforeseen incompatibilities please file a bug"
	ewarn "on http://bugs.gentoo.org."
	ewarn ""
}
