# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/taglib/taglib-1.2.ebuild,v 1.7 2004/11/01 10:07:58 kloeri Exp $

inherit flag-o-matic

DESCRIPTION="A library for reading and editing audio meta data"
HOMEPAGE="http://developer.kde.org/~wheeler/index.html"
SRC_URI="http://developer.kde.org/~wheeler/files/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc hppa amd64 alpha ~ia64 ~ppc64"
IUSE="debug"

DEPEND=">=sys-devel/autoconf-2.58"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -rf autom4te.cache
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.7
	aclocal && autoconf && automake || die "autotools failed"
}

src_compile() {
	replace-flags -O3 -O2
	econf `use_enable debug` || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} destdir=${D} || die
}
