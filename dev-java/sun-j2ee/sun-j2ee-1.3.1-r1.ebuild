# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-j2ee/sun-j2ee-1.3.1-r1.ebuild,v 1.3 2003/05/24 05:37:50 absinthe Exp $

At=j2sdkee-1_3_1-linux.tar.gz
S=${WORKDIR}/j2sdkee1.3.1
DESCRIPTION="Sun's Java 2 Enterprise Edition Development Kit"
SRC_URI=""
HOMEPAGE="http://java.sun.com/j2ee/download.html#sdk"
DEPEND="virtual/glibc
		>=lib-compat-1.1"
RDEPEND=">=virtual/jre-1.3.1"
PROVIDE="virtual/j2ee-1.3.1"
LICENSE="sun-bcla-j2ee"
SLOT="0"
KEYWORDS="x86 -ppc"
IUSE="doc"

src_unpack() {
	if [ ! -f ${DISTDIR}/${At} ] ; then
		die "Please download ${At} from ${HOMEPAGE} to ${DISTDIR}"
	fi
	unpack ${At}
}

src_install () {
	local dirs="bin lib conf config cloudscape lib images nativelib repository public_html logs help images"
	
	dodir /opt/${P}
	for i in $dirs ; do
		cp -a $i ${D}/opt/${P}/
	done
	
	dodoc LICENSE README
	if [ -n "`use doc`" ] ; then
		dohtml -r doc/*
	fi
}

src_postinst() {
	einfo "Remember to set JAVA_HOME before running /opt/${P}/bin/j2ee"
	einfo "A set of sample configuration files (that work) can be found in /opt/${P}/conf and /opt/${P}/config"
}
