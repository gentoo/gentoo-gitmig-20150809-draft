# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/zziplib/zziplib-0.13.59-r1.ebuild,v 1.7 2010/07/31 20:13:40 armin76 Exp $

EAPI="2"

inherit libtool eutils flag-o-matic

DESCRIPTION="Lightweight library used to easily extract data from files archived in a single zip file"
HOMEPAGE="http://zziplib.sourceforge.net/"
SRC_URI="mirror://sourceforge/zziplib/${P}.tar.bz2"

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ~ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x64-freebsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="doc sdl static-libs test"

RDEPEND="sys-libs/zlib
	sdl? ( >=media-libs/libsdl-1.2.6 )"
DEPEND="${RDEPEND}
	>=dev-lang/python-2.4
	dev-util/pkgconfig
	test? ( app-arch/zip )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.13.49-SDL-test.patch
	# zziplib tries to install backwards compat symlinks we dont want
	sed -i -e '/^zzip-postinstall:/s|$|\ndisable-this:|' Makefile.in || die
	sed -i -e '/^install-exec-local:/s|$|\ndisable-this:|' zzip/Makefile.in || die
	elibtoolize
}

src_configure() {
	append-flags -fno-strict-aliasing # bug reported upstream
	export ac_cv_path_XMLTO= # man pages are bundled in .tar's
	econf \
		$(use_enable sdl) \
		$(use_enable static-libs static)
}

src_test() {
	# need this because `make test` will always return true
	# tests fail with -j > 1 (bug #241186)
	emake -j1 check || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	# fowners fails when we don't have enough permissions (Prefix)
	if [[ ${EUID} == 0 ]] ; then
		fowners -R root /usr/share/man || die #321975
	fi

	if ! use static-libs ; then
		find "${D}" -type f -name '*.la' -exec rm {} + \
			|| die "la removal failed"
	fi

	dodoc ChangeLog README TODO

	if use doc ; then
		dohtml -r docs/* || die 'dohtml failed'
	fi
}
