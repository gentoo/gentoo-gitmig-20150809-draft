# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License
# $Header: /var/cvsroot/gentoo-x86/app-text/wv/wv-0.7.1.ebuild,v 1.7 2002/08/16 02:42:02 murphy Exp $



S=${WORKDIR}/${P}
DESCRIPTION="tool for convertion of MSWord doc and rtf files to something readable"
SRC_URI="mirror://sourceforge/wvware/wv-0.7.1.tar.gz"
HOMEPAGE="http://www.wvware.com"
KEYWORDS="x86 sparc sparc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	>=sys-devel/gcc-2.95.2
	>=media-libs/libwmf-0.2.2 
	>=media-libs/freetype-2.0.1
	sys-libs/zlib
	media-libs/libpng"
	
RDEPEND="media-gfx/imagemagick"		

rc_unpack() {
        unpack ${A}

        cd ${S}
		patch -p1 < ${FILESDIR}/wv-0.7.1-rvt.patch
}


src_compile() {
	
	unset CXXFLAGS
	unset CFLAGS

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-docdir=/usr/share/doc/${PF} || die "./configure failed"

	emake || die
}

src_install () {
    make \
        prefix=${D}/usr \
        mandir=${D}/usr/share/man \
        infodir=${D}/usr/share/info \
        install || die
}
