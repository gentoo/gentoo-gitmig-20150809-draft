# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ucl/ucl-1.01-r1.ebuild,v 1.11 2004/04/06 03:02:44 vapier Exp $

DESCRIPTION="UCL: The UCL Compression Library"
HOMEPAGE="http://www.oberhumer.com/opensource/ucl/"
SRC_URI="http://www.oberhumer.com/opensource/ucl/download/ucl-1.01.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ppc64"

src_compile() {
	# Doing this b/c UCL will be included in the kernel
	# at some point, and will be fixed properly then
	# besides, this is lu_zero's build
	append-flags -fPIC

	econf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
}
