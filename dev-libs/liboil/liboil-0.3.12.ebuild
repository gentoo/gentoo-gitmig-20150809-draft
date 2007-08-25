# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/liboil/liboil-0.3.12.ebuild,v 1.5 2007/08/25 22:38:58 vapier Exp $

inherit flag-o-matic autotools

DESCRIPTION="library of simple functions that are optimized for various CPUs"
HOMEPAGE="http://liboil.freedesktop.org/"
SRC_URI="http://liboil.freedesktop.org/download/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0.3"
KEYWORDS="alpha ~amd64 arm ~hppa ia64 ppc sh sparc x86 ~x86-fbsd"
IUSE="doc"

DEPEND="=dev-libs/glib-2*"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/liboil-0.3.10-sse2revert.diff
	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	strip-flags
	filter-flags -O?
	append-flags -O2
	econf $(use_enable doc gtk-doc) || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
