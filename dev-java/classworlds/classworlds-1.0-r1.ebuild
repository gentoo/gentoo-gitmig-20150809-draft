# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/classworlds/classworlds-1.0-r1.ebuild,v 1.2 2004/02/19 20:59:21 karltk Exp $

inherit java-pkg

DESCRIPTION="Advanced classloader framework"
HOMEPAGE="http://dist.codehaus.org/classworlds/distributions/classworlds-1.0-src.tar.gz"
SRC_URI="http://dist.codehaus.org/classworlds/distributions/${P}-src.tar.gz"
LICENSE="codehaus-classworlds"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"
DEPEND="=dev-java/xerces-2.6*
	=dev-java/junit-3.8*
	=dev-java/ant-1.5*"
S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/build-${PV}.xml ${S}/build.xml
	mkdir -p ${S}/target/lib
	(
		cd ${S}/target/lib
		java-pkg_jar-from ant ant.jar ant-1.5.jar
		java-pkg_jar-from ant ant-optional.jar ant-optional-1.5.jar
		java-pkg_jar-from junit junit.jar junit-3.8.1.jar
		java-pkg_jar-from xerces xerces.jar xerces-2.6.0.jar
		java-pkg_jar-from xerces xml-apis.jar xml-apis-2.6.0.jar
	)
}

src_compile() {
	ant jar || die
	if (use doc) ; then
		ant javadoc || die
	fi
}

src_install() {
	dodoc LICENSE.txt
	dojar target/classworlds-1.0.jar
	use doc && dohtml -r dist/docs/api
}
