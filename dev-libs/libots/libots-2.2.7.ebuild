# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libots/libots-2.2.7.ebuild,v 1.9 2004/07/14 14:45:13 agriffis Exp $

At="libots-2.2.7-2.alpha.rpm"
S=${WORKDIR}/usr/lib/compaq/libots-2.2.7
SRC_URI="ftp://ftp.compaq.com/pub/products/linuxdevtools/latest/${At}"
DESCRIPTION="Compaq Linux optimized runtime for Alpha/Linux/GNU"
HOMEPAGE="http://www.support.compaq.com/alpha-tools/"
DEPEND="virtual/libc
	app-arch/rpm2targz "
RDEPEND="$DEPEND"
LICENSE="compaq-sdla"
SLOT="2.2.7"
KEYWORDS="-x86 -ppc -sparc alpha"
IUSE=""

src_unpack() {
	#if [ ! -f ${DISTDIR}/${At} ] ; then
	#	die "Please download ${At} from ${HOMEPAGE}"
	#fi
	rpm2targz ${DISTDIR}/${At}
	tar zxf libots-2.2.7-2.alpha.tar.gz
}

src_install () {
	dodir /usr/lib

	cp libots.* ${D}/usr/lib

	dodoc README
}
