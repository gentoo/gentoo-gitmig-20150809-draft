# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/g-wrap/g-wrap-1.9.8.ebuild,v 1.5 2007/08/29 17:34:21 hkbst Exp $

inherit eutils autotools

DESCRIPTION="A tool for exporting C libraries into Scheme"
HOMEPAGE="http://www.nongnu.org/g-wrap/"
SRC_URI="http://download.savannah.gnu.org/releases/g-wrap/${P}.tar.gz
	http://dev.gentoo.org/~dberkholz/distfiles/${P}-gcc-4.2.0.patch.bz2"
KEYWORDS="~alpha ~ppc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

# guile-lib for srfi-34, srfi-35
DEPEND="dev-scheme/guile
	=dev-libs/glib-2*
	!=dev-libs/libffi-4*
	dev-scheme/guile-lib"

RDEPEND="${DEPEND}"

pkg_setup() {
	if has_version =dev-scheme/guile-1.8*; then
		built_with_use dev-scheme/guile deprecated || die "guile must be built with deprecated use flag"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${FILESDIR}/libffi_automagic.patch
	epatch ${FILESDIR}/${PV}-fix-ffi-build-issue.patch

	pushd libffi
	epatch ${DISTDIR}/${P}-gcc-4.2.0.patch.bz2
	epatch ${FILESDIR}/${PV}-fix-gcc-4.2.0-libffi.patch
	popd

	AT_M4DIR="${S}/m4" eautoreconf
}

#looks like parallel build and install fails occasionally
src_compile() {
	econf --with-glib --disable-Werror
	emake -j1 || die 'make failed'
#	emake -j1 -C libffi || die 'make libffi failed'
}

src_install () {
	emake -j1 DESTDIR="${D}" install || die "make install failed"
#	emake -C libffi -j1 DESTDIR="${D}" install || die 'make libffi failed'
	dodoc AUTHORS ChangeLog NEWS README THANKS
	insinto /usr/share/guile/site/srfi
	doins lib/srfi/srfi*
}
