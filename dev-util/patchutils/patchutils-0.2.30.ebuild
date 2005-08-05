# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/patchutils/patchutils-0.2.30.ebuild,v 1.9 2005/08/05 18:56:39 ciaranm Exp $

DESCRIPTION="A collection of tools that operate on patch files"
HOMEPAGE="http://cyberelk.net/tim/patchutils/"
SRC_URI="http://cyberelk.net/tim/data/patchutils/stable/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha mips hppa amd64 ia64 ppc64"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	# we don't have gendiff
	sed -i -e '/gendiff/d' Makefile.am
	WANT_AUTOMAKE=1.8 aclocal || die "aclocal failed"
	WANT_AUTOCONF=2.5 autoconf || die "autoconf failed"
	WANT_AUTOMAKE=1.8 automake || die "automake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS BUGS COPYING ChangeLog NEWS README TODO
}
