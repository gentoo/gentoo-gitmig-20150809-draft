# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/STLport/STLport-4.6.2-r1.ebuild,v 1.1 2004/07/05 13:49:45 dholm Exp $

inherit eutils

DESCRIPTION="C++ STL library"
HOMEPAGE="http://www.stlport.org/"
SRC_URI="http://www.stlport.org/archive/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-optimize.patch
	epatch ${FILESDIR}/${PV}-gcc-includes.patch
	sed -i 's:-D_STLP_REAL_LOCALE_IMPLEMENTED::' src/gcc-linux.mak
}

src_compile() {
	cd src
	emake -f gcc-linux.mak || die "Compile failed"
}

src_install() {
	dodir /usr/include
	cp -R ${S}/stlport ${D}/usr/include
	rm -rf ${D}/usr/include/stlport/BC50

	dodir /usr/lib
	cp -R ${S}/lib/* ${D}/usr/lib/
	dosym libstlport_gcc_stldebug.so /usr/lib/libstlport_gcc_debug.so
	rm -rf ${D}/usr/lib/obj

	cd ${S}/etc/
	dodoc ChangeLog* README TODO *.txt

	cd ${S}
	dohtml -r doc

	dodir /usr/lib/pkgconfig
	cp ${FILESDIR}/stlport.pc ${D}/usr/lib/pkgconfig
	# Update STLport version here!
	sed -i 's:@VERSION@:4.6.2:' ${D}/usr/lib/pkgconfig/stlport.pc
}
