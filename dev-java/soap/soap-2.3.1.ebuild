# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/soap/soap-2.3.1.ebuild,v 1.3 2004/10/22 10:19:27 absinthe Exp $

inherit java-pkg
DESCRIPTION="Apache SOAP (Simple Object Access Protocol) is an implementation of the SOAP submission to W3C"
HOMEPAGE="http://ws.apache.org/soap/"
SRC_URI="mirror://apache/ws/soap/version-${PV}/soap-src-${PV}.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"
DEPEND="virtual/jdk
	dev-java/sun-javamail-bin
	dev-java/sun-jaf-bin
	~dev-java/servletapi-2.4
	>=dev-java/ant-1.6.0"
RDEPEND="virtual/jre"

MY_P=${P//./_}
S=${WORKDIR}/${MY_P}

src_compile() {
	local antflags="compile"
	use doc && antflags="${antflags} javadocs"
	antflags="${antflags} -lib $(java-config -p xerces-2,sun-javamail-bin,sun-jaf-bin,servletapi-2.4)"
	ant ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_dojar build/lib/soap.jar

	use doc && java-pkg_dohtml -r build/javadocs/
}
