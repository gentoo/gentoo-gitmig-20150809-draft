# Copyright 1999-2002 Gentoo Technologies, Inc
# Distributed under the terms of the GNU General Public License v2

# Unfortunately, its true version name is illegal for portage
P="udftools-1.0.0b2"
S=${WORKDIR}/${P}
DESCRIPTION="Ben Fennema's tools for packet writing and the UDF filesystem"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/linux-udf/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/linux-udf/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc ChangeLog COPYING
}
