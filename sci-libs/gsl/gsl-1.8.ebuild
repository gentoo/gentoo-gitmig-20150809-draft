# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/gsl/gsl-1.8.ebuild,v 1.1 2006/04/11 15:02:48 george Exp $

inherit flag-o-matic

DESCRIPTION="The GNU Scientific Library"
HOMEPAGE="http://www.gnu.org/software/gsl/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	replace-cpu-flags k6 k6-2 k6-3 i586
	filter-flags -ffast-math
	filter-mfpmath sse

	econf --disable-libtool-lock || die
	emake || die 'emake failed.'
}

src_test() {
	make check || die 'make check failed.'
}

src_install() {
	einstall || die 'einstall failed.'
	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README SUPPORT THANKS TODO
}
