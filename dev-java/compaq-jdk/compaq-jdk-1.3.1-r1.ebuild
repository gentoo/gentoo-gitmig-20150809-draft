# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/compaq-jdk/compaq-jdk-1.3.1-r1.ebuild,v 1.1 2004/01/10 02:51:09 agriffis Exp $

IUSE="doc"

inherit java

S=${WORKDIR}/jdk1.3.1
SRC_URI="ftp://ftp.compaq.com/pub/products/linuxdevtools/latest/jdk-1.3.1-1-linux-alpha.rpm"
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
	virtual/jdk-1.3.1
	virtual/java-scheme-2"
LICENSE="compaq-sdla"
SLOT="1.3"
KEYWORDS="-* alpha"

src_unpack() {
	rpm2targz ${DISTDIR}/jdk-1.3.1-1-linux-alpha.rpm
	tar xzf jdk-1.3.1-1-linux-alpha.tar.gz >& /dev/null
	mv usr/java/jdk1.3.1 .
}

src_install () {
	dodir /opt/${P}
	cp -a bin include include-old jre lib ${D}/opt/${P}

	dodoc COPYRIGHT README LICENSE
	dohtml README.html
	doman man/man1/*.1

	dodir /opt/${P}/share
	cp -a demo src.jar ${D}/opt/${P}/share

	set_java_env ${FILESDIR}/${VMHANDLE} || die
}

pkg_postinst () {
	# Set as default VM if none exists
	java_pkg_postinst
}
