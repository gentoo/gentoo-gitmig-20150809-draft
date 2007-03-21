# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/hashit/hashit-0.9.4.ebuild,v 1.2 2007/03/21 10:10:23 pyrania Exp $

inherit flag-o-matic toolchain-funcs multilib

DESCRIPTION="Hashit is a library of generic hash tables that supports different collision handling methods with one common interface. Both data and keys can be of any type. It is small and easy to use."
HOMEPAGE="http://www.pleyades.net/david/projects/"
SRC_URI="http://www.pleyades.net/david/projects/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	use amd64 && append-flags -fPIC
}

src_compile() {
	./0 --prefix="${D}"/usr \
		--infodir="${D}"/usr/share/info:"${D}"/usr/X11R6/info \
		--libdir="${D}/usr/$(get_libdir)"
	emake GCC="$(tc-getCC)" LD="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	rm "${D}/usr/$(get_libdir)/libhashit.so"
	dosym libhashit.so.1.0 /usr/"$(get_libdir)"/libhashit.so
	dosym libhashit.so /usr/"$(get_libdir)"/libhashit.so.0
}
