# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Don't attempt to introduce $CFLAGS usage, docs say result will be slower.

S=${WORKDIR}/${P}
DESCRIPTION="ZSNES is a SNES (Super Nintendo) emulator that uses x86 assembly."
SRC_URI="mirror://sourceforge/zsnes/zsnes135src.tar.gz"
HOMEPAGE="http://www.zsnes.com/"
LICENSE="GPL-2"
KEYWORDS="x86 -sparc -sparc64 -ppc"
SLOT="0"

RDEPEND="opengl? ( virtual/opengl )
	virtual/x11
	>=media-libs/libsdl-1.2.0
	sys-libs/zlib
	media-libs/libpng"

DEPEND="${RDEPEND}
	>=dev-lang/nasm-0.98"
	

src_compile() {
	patch -p1 < ${FILESDIR}/${P}-cvs.patch || die "CVS patch failed"
	cd ${S}/src
	use opengl || myconf="--without-opengl"
	./configure --prefix=/usr --host=${CHOST} $myconf || die
	make || die
}
src_install () {
	cd ${S}/src
	into /usr
	dobin zsnes
	doman linux/zsnes.1
	cd ${S}
	dodoc *.txt linux/*
}
