# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libbsd/libbsd-0.3.0.ebuild,v 1.1 2011/11/18 17:16:38 ssuominen Exp $

EAPI=4
inherit multilib toolchain-funcs

DESCRIPTION="A BSD compatibility library"
HOMEPAGE="http://libbsd.freedesktop.org/wiki/"
SRC_URI="http://libbsd.freedesktop.org/releases/${P}.tar.gz"

LICENSE="BSD BSD-2 BSD-4 ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

pkg_setup() {
	mylibbsdconf=(
		AR="$(tc-getAR)"
		CC="$(tc-getCC)"
		libdir=/usr/$(get_libdir)
		usrlibdir=/usr/$(get_libdir)
		)

	local f="${ROOT}"usr/$(get_libdir)/libbsd.a
	if ! has_version dev-libs/libbsd; then
		if [[ -e ${f} ]]; then
			eerror "You need to remove ${f} by hand or re-emerge sys-libs/glibc first."
			die "You need to remove ${f} by hand or re-emerge sys-libs/glibc first."
		fi
	fi
}

src_prepare() {
	# Instead of replacing upstream warning flags, append to them
	sed -i -e 's:CFLAGS ?= -g:CFLAGS +=:' Makefile || die

	if ! use static-libs; then
		sed -i \
			-e '/^libs/s:$(LIB_STATIC)::' \
			-e 's:install -m644 $(LIB_STATIC):-&:' \
			Makefile || die
	fi
}

src_compile() {
	emake "${mylibbsdconf[@]}"
}

src_install() {
	emake DESTDIR="${D}" "${mylibbsdconf[@]}" install
	dodoc ChangeLog README TODO

	# Fix file collision with dev-libs/elfutils by removing deprecated include
	rm -f "${ED}"usr/include/nlist.h
}
