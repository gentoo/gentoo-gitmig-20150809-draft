# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tre/tre-0.7.0.ebuild,v 1.2 2004/11/21 10:51:27 dragonheart Exp $

IUSE="nls static"

DESCRIPTION="Lightweight, robust, and efficient POSIX compliant regexp matching library."
HOMEPAGE="http://laurikari.net/tre/index.html"
SRC_URI="http://laurikari.net/tre/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~amd64"

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
	cd ${S}
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
	cd ${S}
	dohtml doc/tre-api.html doc/tre-syntax.html
}


pkg_postinst() {
	ewarn "Both app-misc/glimpse, app-text/agrep and this package provide agrep."
	ewarn "they seem to be similar but just to let you know."
	ewarn "If this causes a problem please do a bug report"
	ewarn "bugs.gentoo.org."
}
