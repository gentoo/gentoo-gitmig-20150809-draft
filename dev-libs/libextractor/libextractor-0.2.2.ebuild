# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libextractor/libextractor-0.2.2.ebuild,v 1.8 2004/03/25 03:19:59 weeve Exp $

inherit libtool

IUSE="oggvorbis static"
DESCRIPTION="A simple library for keyword extraction"
HOMEPAGE="http://www.ovmj.org/~samanta/libextractor"
SRC_URI="http://www.ovmj.org/~samanta/libextractor/download/${P}.tar.bz2"
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc"
# does not work with rpm-4.2
DEPEND=">=sys-devel/libtool-1.4.1
	<app-arch/rpm-4.2
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )"

src_unpack() {
	unpack ${A}
	# patch their half baked attempt at supporting ogg vorbis
	epatch ${FILESDIR}/${P}-vorbisfile.patch || die "patch failed"
}

src_compile() {
	elibtoolize

	local myconf
	myconf="--with-gnu-ld"
	export CPPFLAGS="-I/usr/include/rpm"
	use static \
		&& myconf="${myconf} --enable-static" \
		|| myconf="${myconf} --disable-static"
	econf ${myconf}
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
}
