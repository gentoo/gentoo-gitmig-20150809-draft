# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/patchutils/patchutils-0.2.31.ebuild,v 1.8 2008/11/16 17:04:02 jer Exp $

WANT_AUTOMAKE=1.8
inherit autotools

DESCRIPTION="A collection of tools that operate on patch files"
HOMEPAGE="http://cyberelk.net/tim/patchutils/"
SRC_URI="http://cyberelk.net/tim/data/patchutils/stable/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	# we don't have gendiff
	sed -i -e '/gendiff/d' Makefile.am
	WANT_AUTOMAKE=1.8 WANT_AUTOCONF=2.5 \
	eautoreconf || die "eautoreconf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
}
