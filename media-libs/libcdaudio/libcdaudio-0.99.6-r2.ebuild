# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libcdaudio/libcdaudio-0.99.6-r2.ebuild,v 1.5 2004/03/19 07:56:04 mr_bones_ Exp $

inherit flag-o-matic

IUSE=""

DESCRIPTION="a library of cd audio related routines"
SRC_URI="mirror://sourceforge/libcdaudio/${P}.tar.gz"
HOMEPAGE="http://libcdaudio.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc ~alpha ~hppa ~mips amd64"

src_compile() {
	patch -p1 < ${FILESDIR}/${P}-sanity-checks.patch

	# -fPIC is required for this library on alpha, see bug #17192
	use alpha && append-flags -fPIC

	econf --enable-threads --with-gnu-ld
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangLog NEWS README README.BeOS README.OSF1 TODO
}
