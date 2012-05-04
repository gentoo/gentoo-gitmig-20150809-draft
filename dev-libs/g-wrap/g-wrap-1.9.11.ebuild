# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/g-wrap/g-wrap-1.9.11.ebuild,v 1.14 2012/05/04 18:35:56 jdhore Exp $

inherit eutils

DESCRIPTION="A tool for exporting C libraries into Scheme"
HOMEPAGE="http://www.nongnu.org/g-wrap/"
SRC_URI="http://download.savannah.gnu.org/releases/g-wrap/${P}.tar.gz"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

# guile-lib for srfi-34, srfi-35
RDEPEND="dev-scheme/guile
	=dev-libs/glib-2*
	virtual/libffi
	dev-scheme/guile-lib"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	if has_version =dev-scheme/guile-1.8*; then
		built_with_use dev-scheme/guile deprecated || die "guile must be built with deprecated use flag"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

#	cp guile/g-wrap-2.0-guile.pc.in guile/g-wrap-2.0-guile.pc.in.old

	sed "s:@LIBFFI_CFLAGS_INSTALLED@:@LIBFFI_CFLAGS@:g" -i guile/g-wrap-2.0-guile.pc.in
	sed "s:@LIBFFI_LIBS_INSTALLED@:@LIBFFI_LIBS@:g" -i guile/g-wrap-2.0-guile.pc.in

#	diff -u guile/g-wrap-2.0-guile.pc.in.old guile/g-wrap-2.0-guile.pc.in
}

src_compile() {
	econf --with-glib --disable-Werror
	emake -j1 || die "make failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS
}
