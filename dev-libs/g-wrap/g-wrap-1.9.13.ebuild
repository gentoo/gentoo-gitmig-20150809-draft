# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/g-wrap/g-wrap-1.9.13.ebuild,v 1.3 2012/07/21 19:04:31 jdhore Exp $

inherit eutils

DESCRIPTION="A tool for exporting C libraries into Scheme"
HOMEPAGE="http://www.nongnu.org/g-wrap/"
SRC_URI="http://download.savannah.gnu.org/releases/g-wrap/${P}.tar.gz"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

# guile-lib for srfi-34, srfi-35
RDEPEND="dev-scheme/guile
	=dev-libs/glib-2*
	virtual/libffi
	dev-scheme/guile-lib"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/indent"

pkg_setup() {
	if has_version =dev-scheme/guile-1.8*; then
		built_with_use dev-scheme/guile deprecated || die "guile must be built with deprecated use flag"
	fi
}

src_compile() {
	econf --disable-Werror --with-glib
	emake -j1 || die "make failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS
}
