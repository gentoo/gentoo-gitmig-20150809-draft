# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdnet/libdnet-1.11-r1.ebuild,v 1.1 2007/08/12 20:21:35 pva Exp $

#WANT_AUTOMAKE=1.6
inherit eutils autotools

DESCRIPTION="simplified, portable interface to several low-level networking routines"
HOMEPAGE="http://libdnet.sourceforge.net/"
SRC_URI="mirror://sourceforge/libdnet/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ia64 ~ppc ppc64 sparc x86"
IUSE="python"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's/suite_free(s);//' test/check/*.c || die "sed failed"
	epatch "${FILESDIR}"/${PN}-1.10-gcc4.diff
	# Without libtoolze --force build with --disable-static produce libraries
	# without .so extension and applications does not see library.
	libtoolize --force
	AT_M4DIR="config"
	eautoreconf
}

src_compile () {
	econf $(use_with python) || die "econf failed"
	emake || die "emake failed"
}

src_test() {
	einfo "self test fails with permission problems"
}

src_install () {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README THANKS TODO
}
