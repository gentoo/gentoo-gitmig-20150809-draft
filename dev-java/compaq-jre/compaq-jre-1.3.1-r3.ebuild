# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/compaq-jre/compaq-jre-1.3.1-r3.ebuild,v 1.9 2005/08/26 12:33:57 flameeyes Exp $

IUSE="doc"

inherit java fixheadtails

S=${WORKDIR}/jre${PV}
SRC_URI="ftp://ftp.compaq.com/pub/products/linuxdevtools/latest/jre-${PV}-1-linux-alpha.rpm"
HOMEPAGE="ftp://ftp.compaq.com/pub/products/linuxdevtools/latest/"
DESCRIPTION="Compaq Java Development Kit ${PV} for Alpha/Linux/GNU"
DEPEND="virtual/libc
	app-arch/rpm2targz
	dev-libs/libots
	dev-libs/libcpml
	>=dev-java/java-config-0.2.5
	>=x11-libs/openmotif-2.1.30-r1
	doc? ( ~dev-java/java-sdk-docs-${PV} )"
RDEPEND="$DEPEND"
PROVIDE="virtual/jre"
LICENSE="compaq-sdla"
SLOT="1.3"
KEYWORDS="-* alpha"

src_unpack() {
	rpm2targz ${DISTDIR}/jre-${PV}-1-linux-alpha.rpm || die
	tar zxf jre-${PV}-1-linux-alpha.tar.gz >& /dev/null || die
	mv usr/java/jre${PV} .
	ht_fix_file jre${PV}/bin/.java_wrapper
}

src_install() {
	dodir /opt/${P}
	cp -pPR bin lib ${D}/opt/${P} || die

	dodoc COPYRIGHT CHANGES LICENSE
	dohtml readme.html Welcome.html
	doman man/man1/*.1

	set_java_env ${FILESDIR}/${VMHANDLE} || die
}
