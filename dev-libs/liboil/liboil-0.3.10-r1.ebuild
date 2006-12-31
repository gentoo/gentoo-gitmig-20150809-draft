# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/liboil/liboil-0.3.10-r1.ebuild,v 1.3 2006/12/31 22:55:24 dirtyepic Exp $

inherit flag-o-matic autotools

DESCRIPTION="library of simple functions that are optimized for various CPUs"
HOMEPAGE="http://www.schleef.org/liboil/"
SRC_URI="http://www.schleef.org/${PN}/download/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0.3"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc"

RDEPEND="=dev-libs/glib-2*"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/liboil-0.3.10-sse2revert.diff
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
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
