# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/soap/soap-2.3.1.ebuild,v 1.4 2005/05/21 17:53:33 luckyduck Exp $

inherit java-pkg

MY_P=${P//./_}
DESCRIPTION="Apache SOAP (Simple Object Access Protocol) is an implementation of the SOAP submission to W3C"
HOMEPAGE="http://ws.apache.org/soap/"
SRC_URI="mirror://apache/ws/soap/version-${PV}/soap-src-${PV}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="doc jikes source"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-1.6.0
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4
	dev-java/sun-javamail-bin
	dev-java/sun-jaf-bin
	~dev-java/servletapi-2.4"

S=${WORKDIR}/${MY_P}

src_compile() {
	local antflags="compile"
	use doc && antflags="${antflags} javadocs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	antflags="${antflags} -lib" \
		"$(java-config -p xerces-2,sun-javamail-bin,sun-jaf-bin,servletapi-2.4)"
	ant ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_dojar build/lib/soap.jar

	use doc && java-pkg_dohtml -r build/javadocs/
	use source && java-pkg_dosrc src/*
}
