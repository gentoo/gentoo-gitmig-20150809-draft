# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/vigra/vigra-1.3.2.ebuild,v 1.1 2005/03/10 19:26:50 luckyduck Exp $

DESCRIPTION="Vision with Generic Algorithms"
HOMEPAGE="http://kogs-www.informatik.uni-hamburg.de/~koethe/vigra"
SRC_URI="http://kogs-www.informatik.uni-hamburg.de/~koethe/vigra/${P/-}.tar.gz"

LICENSE="VIGRA"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="sys-devel/gcc
		media-libs/libpng
		media-libs/tiff
		media-libs/jpeg
		sys-libs/zlib
		sci-libs/fftw"

S=${WORKDIR}/${P/-}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} prefix=${D}/usr install || die
}

