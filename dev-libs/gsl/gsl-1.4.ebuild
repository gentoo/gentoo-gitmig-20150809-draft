# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gsl/gsl-1.4.ebuild,v 1.13 2004/12/23 20:05:32 corsair Exp $

inherit flag-o-matic

DESCRIPTION="The GNU Scientific Library"
HOMEPAGE="http://sources.redhat.com/gsl/"
SRC_URI="http://mirrors.rcn.net/pub/sourceware/gsl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86 ~ppc64"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	replace-cpu-flags k6 k6-2 k6-3 i586
	filter-flags -ffast-math
	filter-mfpmath sse

	econf --disable-libtool-lock || die
	emake || die
}

src_test() {
	make check || die
}

src_install() {
	einstall || die
	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS TODO THANKS
}
