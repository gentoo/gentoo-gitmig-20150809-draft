# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/compaq-jre/compaq-jre-1.3.1-r1.ebuild,v 1.1 2004/01/10 15:20:27 agriffis Exp $

IUSE="doc"

inherit java

S=${WORKDIR}/jre1.3.1
SRC_URI="ftp://ftp.compaq.com/pub/products/linuxdevtools/latest/jre-1.3.1-1-linux-alpha.rpm"
HOMEPAGE="ftp://ftp.compaq.com/pub/products/linuxdevtools/latest/"
DESCRIPTION="Compaq Java Development Kit 1.3.1 for Alpha/Linux/GNU"
DEPEND="virtual/glibc
	app-arch/rpm2targz
	dev-libs/libots
	dev-libs/libcpml
	>=dev-java/java-config-0.2.5
	>=x11-libs/openmotif-2.1.30-r1
	doc? ( ~dev-java/java-sdk-docs-1.3.1 )"
RDEPEND="$DEPEND"
PROVIDE="virtual/jre-1.3.1
	virtual/java-scheme-2"
LICENSE="compaq-sdla"
SLOT="1.3"
KEYWORDS="-* alpha"

src_unpack() {
	rpm2targz ${DISTDIR}/jre-1.3.1-1-linux-alpha.rpm
	tar zxf jre-1.3.1-1-linux-alpha.tar.gz >& /dev/null
	mv usr/java/jre1.3.1 .
}

src_install () {
	dodir /opt/${P}
	cp -a bin lib ${D}/opt/${P}

	dodoc COPYRIGHT CHANGES LICENSE
	dohtml readme.html Welcome.html
	doman man/man1/*.1

	set_java_env ${FILESDIR}/${VMHANDLE} || die
}

pkg_postinst () {
	# Set as default VM if none exists
	java_pkg_postinst
}
