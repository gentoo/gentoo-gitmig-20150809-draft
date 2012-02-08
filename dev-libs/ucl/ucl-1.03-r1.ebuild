# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ucl/ucl-1.03-r1.ebuild,v 1.4 2012/02/08 01:18:21 jer Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="the UCL Compression Library"
HOMEPAGE="http://www.oberhumer.com/opensource/ucl/"
SRC_URI="http://www.oberhumer.com/opensource/ucl/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-CFLAGS.patch

	# lzo (and ucl) have some weird sort of mfx_* set of autoconf macros
	# which may only be distributed with lzo itself? Rescue them and
	# place them into acinclude.m4 because there doesn't seem to be an
	# m4/...
	sed -n -e '/^AC_DEFUN.*mfx_/,/^])#$/p' aclocal.m4 > acinclude.m4 || die "Unable to rescue mfx_* autoconf macros."
	eautoreconf
}

src_configure() {
	econf --enable-shared
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS NEWS README THANKS TODO
}
