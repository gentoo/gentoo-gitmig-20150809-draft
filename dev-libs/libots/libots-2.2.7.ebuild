# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libots/libots-2.2.7.ebuild,v 1.2 2003/02/13 10:44:39 vapier Exp $

At="libots-2.2.7-2.alpha.rpm"
S=${WORKDIR}/usr/lib/compaq/libots-2.2.7
SRC_URI=""
DESCRIPTION="Compaq Linux optimized runtime for Alpha/Linux/GNU"
HOMEPAGE="http://h18012.www1.hp.com/java/documentation/1.3.1/linux/docs/index.html"
DEPEND="virtual/glibc
	app-arch/rpm2targz "
RDEPEND="$DEPEND"
LICENSE="compaq-sdla"
SLOT="2.2.7"
KEYWORDS="-x86 -ppc -sparc alpha"
	
src_unpack() {
	if [ ! -f ${DISTDIR}/${At} ] ; then
		die "Please download ${At} from ${HOMEPAGE}"
	fi
	rpm2targz ${DISTDIR}/${At}
	tar zxf libots-2.2.7-2.alpha.tar.gz
}

src_install () {
	dodir /usr/lib
	
	cp libots.* ${D}/usr/lib

	dodoc README 
}

