# Copyright 2002 Dwight Schauer
# Distributed under the terms of the GNU General Public License, v2.

S=${WORKDIR}/${P}
DESCRIPTION="CPU statistics monitor utility for X Windows"
SRC_URI="http://www.tigr.net/afterstep/download/ascpu/${P}.tar.gz"
HOMEPAGE="http://www.tigr.net"
DEPEND="sys-devel/gcc 
	sys-apps/fileutils 
	sys-devel/binutils
	virtual/glibc virtual/x11"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

src_unpack() {
	unpack ${A}

	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	econf || die

#	./configure --prefix=${D}/usr || die "Configuration Failed"
    	emake || die "Make Failed"
}

src_install () {
	mkdir -p ${D}/usr/bin ${D}/usr/share/man/man1
	make DESTDIR=${D} install || die
#	einstall || die
	dodoc README INSTALL LICENSE
}
