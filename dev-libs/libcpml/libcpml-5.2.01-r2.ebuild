# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libcpml/libcpml-5.2.01-r2.ebuild,v 1.2 2003/04/18 16:13:10 taviso Exp $

S=${WORKDIR}/usr
SRC_URI=""
DESCRIPTION="Compaq Linux optimized math library for Alpha/Linux/GNU"
HOMEPAGE="ftp://ftp.compaq.com/pub/products/linuxdevtools/latest/downloads.html"
DEPEND="virtual/glibc
	app-arch/rpm2targz "
RDEPEND="$DEPEND"
LICENSE="compaq-sdla"
SLOT="5.2.01"
KEYWORDS="-x86 -ppc -sparc ~alpha"
IUSE="ev6"
	
src_unpack() {
	local EV; use ev6 && EV=ev6 || EV=ev5
	At="cpml_${EV}-5.2.0-1.alpha.rpm"
	if [ ! -f ${DISTDIR}/${At} ] ; then
		die "Please download ${At} from ${HOMEPAGE}"
	fi

#	rpm2targz ${DISTDIR}/${At}
#	tar zxf cpml_${EV}-5.2.0-1.alpha.tar.gz 

	# agriffis' improved method for rpm extraction
	# 
	i=${DISTDIR}/${At}
	dd ibs=`rpmoffset < ${i}` skip=1 if=$i 2>/dev/null \
		| gzip -dc | cpio -idmu 2>/dev/null \
		&& find usr -type d -print0 | xargs -0 chmod a+rx	
	eend ${?}
	assert "Failed to extract ${At%.rpm}.tar.gz"
	
}

src_compile () {
	local EV; use ev6 && EV=ev6 || EV=ev5
	cd ${WORKDIR}/usr/lib/compaq/cpml-5.2.0
	ld -shared -o libcpml_${EV}.so -soname libcpml.so -whole-archive libcpml_${EV}.a -no-whole-archive -lots
}

src_install () {
	local EV; use ev6 && EV=ev6 || EV=ev5

	mv ${WORKDIR}/usr ${D}
	
	dodir /usr/lib/
	dosym ./compaq/cpml-5.2.0/libcpml_${EV}.so /usr/lib/libcpml_${EV}.so 
	dosym ./compaq/cpml-5.2.0/libcpml_${EV}.a /usr/lib/libcpml_${EV}.a
	
	dodir /usr/share
	mv ${D}/usr/doc ${D}/usr/share
	prepalldocs	
	
	dosym ./compaq/cpml-5.2.0/libcpml_${EV}.so /usr/lib/libcpml.so
	dosym ./compaq/cpml-5.2.0/libcpml_${EV}.a /usr/lib/libcpml.a
}

