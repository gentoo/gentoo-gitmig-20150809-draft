# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Libraries and utilities to communicate with a Psion palmtop via serial."
HOMEPAGE="http://plptools.sourceforge.net"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/plptools/${P}.tar.gz"
LICENSE="as-is"

SLOT="0"
KEYWORDS="~x86"
DEPEND="virtual/glibc"
S="${WORKDIR}/${P}"

src_compile() {
	patch -p0 < ${FILESDIR}/${P}-gentoo.patch | die "Patch failed!"

	local myconf

	myconf="${myconf} --disable-kde"
	
	./configure ${myconf} --prefix=/usr || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	
	dodoc CHANGES README TODO
	
	insinto /etc/conf.d
	newins ${FILESDIR}/psion.conf psion
	
	exeinto /etc/init.d
	doexe ${FILESDIR}/psion
}
