# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/compaq-jdk/compaq-jdk-1.3.1-r4.ebuild,v 1.1 2006/08/12 19:07:18 betelgeuse Exp $

inherit java fixheadtails

S=${WORKDIR}/jdk${PV}
SRC_URI="ftp://ftp.compaq.com/pub/products/linuxdevtools/latest/jdk-${PV}-1-linux-alpha.rpm"
HOMEPAGE="ftp://ftp.compaq.com/pub/products/linuxdevtools/latest/"
DESCRIPTION="Compaq Java Development Kit ${PV} for Alpha/Linux/GNU"
DEPEND="
	app-arch/rpm2targz
	dev-libs/libots
	dev-libs/libcpml
	>=x11-libs/openmotif-2.1.30-r1
	doc? ( ~dev-java/java-sdk-docs-${PV} )"
RDEPEND="$DEPEND"
LICENSE="compaq-sdla"
SLOT="1.3"
KEYWORDS="-* ~alpha"
IUSE="doc"

src_unpack() {
	rpm2targz ${DISTDIR}/jdk-${PV}-1-linux-alpha.rpm || die
	tar xzf jdk-${PV}-1-linux-alpha.tar.gz >& /dev/null || die
	mv usr/java/jdk${PV} .
	ht_fix_file jdk${PV}/bin/.java_wrapper jdk${PV}/jre/bin/.java_wrapper
}

src_install() {
	dodir /opt/${P}
	cp -pPR bin include include-old jre lib ${D}/opt/${P} || die

	dodoc COPYRIGHT README LICENSE
	dohtml README.html
	doman man/man1/*.1

	dodir /opt/${P}/share
	cp -pPR demo src.jar ${D}/opt/${P}/share || die

	set_java_env ${FILESDIR}/${VMHANDLE} || die
}
