# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libbsd/libbsd-0.2.0.ebuild,v 1.2 2011/10/22 18:54:21 hwoarang Exp $

EAPI=4
inherit eutils multilib toolchain-funcs

DESCRIPTION="A BSD compatibility library"
HOMEPAGE="http://libbsd.freedesktop.org/wiki/"
SRC_URI="http://libbsd.freedesktop.org/releases/${P}.tar.gz"

LICENSE="BSD BSD-2 BSD-4 ISC"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

pkg_setup() {
	mylibbsdconf=(
		libdir=/usr/$(get_libdir)
		usrlibdir=/usr/$(get_libdir)
		pkgconfigdir=/usr/$(get_libdir)/pkgconfig
	)
	if ! has_version "dev-libs/libbsd"; then
		if [[ -e ${ROOT}/usr/$(get_libdir)/libbsd.a ]]; then
			eerror
			eerror "Sorry, you will need to rebuild sys-libs/glibc before"
			eerror "installing dev-libs/libbsd. (emerge -1 sys-libs/glibc)"
			eerror
			die "Unable to install until glibc rebuilt."
		fi
	fi
}

src_prepare() {
	mv include/nlist.h include/bsd/nlist.h
	epatch "${FILESDIR}"/${P}-arc4random-prototypes.patch \
		"${FILESDIR}"/${P}-move-nlist.patch
	sed -i \
		-e 's/gcc /$(CC) ${LDFLAGS} /' \
		-e 's/^	ar /	$(AR) /' \
		Makefile || die "Fix Makefile"
	# Fix header paths in manpages. Has to be done in steps because
	# not every reference in every man page is wrong.
	sed -i \
		-e 's^\.In stdio.h^.In bsd/stdio.h^' \
		src/fgetln.3 \
		src/fmtcheck.3 || die "Fix stdio.h man pages"
	sed -i \
		-e 's^\.In stdlib.h^.In bsd/stdlib.h^' \
		src/humanize_number.3 \
		src/strtonum.3 \
		src/arc4random.3 || die "Fix stdlib.h man pages"
	sed -i \
		-e 's^\.In unistd.h^.In bsd/unistd.h^' \
		src/setmode.3 || die "Fix unistd.h man pages"
	sed -i \
		-e 's^\.In string.h^.In bsd/string.h^' \
		src/strlcpy.3 \
		src/strmode.3 || die "Fix string.h man pages"
	sed -i \
		-e 's^\.Fd #include <mdX.h>^.Fd #include <bsd/mdX.h>^' \
		src/mdX.3 || die "Fix md5.h man pages"
	sed -i \
		-e 's^\.Fd #include <readpassphrase.h>^.Fd #include <bsd/readpassphrase.h>^' \
		src/readpassphrase.3 || die "Fix readpassphrase man page"
	sed -i \
		-e 's^\.In nlist.h^.In bsd/nlist.h^' \
		src/nlist.3
}

src_compile() {
	tc-export CC AR
	emake ${mylibbsdconf[@]}
}

src_install() {
	emake DESTDIR="${D}" ${mylibbsdconf[@]} install
	dodoc ChangeLog README TODO Versions
}
