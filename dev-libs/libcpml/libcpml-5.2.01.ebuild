# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libcpml/libcpml-5.2.01.ebuild,v 1.6 2004/07/14 14:32:25 agriffis Exp $

At="cpml_ev5-5.2.0-1.alpha.rpm"
S=${WORKDIR}/usr
SRC_URI=""
DESCRIPTION="Compaq Linux optimized (ev5) math library for Alpha/Linux/GNU"
HOMEPAGE="http://h18000.www1.hp.com/math/index.html"
DEPEND="virtual/libc
	app-arch/rpm2targz "
RDEPEND="$DEPEND"
LICENSE="compaq-sdla"
SLOT="5.2.01"
KEYWORDS="-x86 -ppc -sparc alpha"
IUSE=""

src_unpack() {
	if [ ! -f ${DISTDIR}/${At} ] ; then
		die "Please download ${At} from ${HOMEPAGE}"
	fi
	rpm2targz ${DISTDIR}/${At}
	tar zxf cpml_ev5-5.2.0-1.alpha.tar.gz
	mv usr/doc/cpml-5.2.0/* usr

}

src_compile () {
	cd ${WORKDIR}/usr/lib/compaq/cpml-5.2.0
	ld -shared -o libcpml_ev5.so -soname libcpml.so -whole-archive libcpml_ev5.a -no-whole-archive -lots
}

src_install () {
	dodir /usr/lib
	cp -a lib/compaq/cpml-5.2.0/libcpml* ${D}/usr/lib

	dodir /usr/include
	cp lib/compaq/cpml-5.2.0/cpml.h ${D}/usr/include

	dodoc README Release_Notes-5.2.0

	cd ${D}/usr/lib/
	ln -s libcpml_ev5.so libcpml.so
	ln -s libcpml_ev5.a libcpml.a
}
