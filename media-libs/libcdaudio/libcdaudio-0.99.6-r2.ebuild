# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libcdaudio/libcdaudio-0.99.6-r2.ebuild,v 1.10 2005/04/05 02:28:10 obz Exp $

inherit flag-o-matic

DESCRIPTION="a library of cd audio related routines"
SRC_URI="mirror://sourceforge/libcdaudio/${P}.tar.gz"
HOMEPAGE="http://libcdaudio.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc ~alpha ~hppa ~mips amd64"
IUSE=""

src_compile() {
	patch -p1 < ${FILESDIR}/${P}-sanity-checks.patch

	# -fPIC is required for this library on alpha, see bug #17192
	use alpha && append-flags -fPIC

	econf --enable-threads --with-gnu-ld || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangLog NEWS README README.BeOS README.OSF1 TODO
}
