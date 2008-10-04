# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/liboil/liboil-0.3.15.ebuild,v 1.7 2008/10/04 15:45:57 ranger Exp $

inherit flag-o-matic

DESCRIPTION="library of simple functions that are optimized for various CPUs"
HOMEPAGE="http://liboil.freedesktop.org/"
SRC_URI="http://liboil.freedesktop.org/download/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0.3"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 ~sh sparc x86 ~x86-fbsd"
IUSE="doc"

DEPEND="=dev-libs/glib-2*"

src_compile() {
	strip-flags
	filter-flags -O?
	append-flags -O2
	econf --disable-dependency-tracking \
		$(use_enable doc gtk-doc) || die "econf failed."
	emake -j1 || die "emake failed."
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS BUG-REPORTING HACKING NEWS README
}
