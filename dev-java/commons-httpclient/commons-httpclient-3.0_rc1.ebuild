# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-httpclient/commons-httpclient-3.0_rc1.ebuild,v 1.1 2005/04/03 13:36:49 axxo Exp $

inherit java-pkg eutils

MY_P=${P/_/-}
DESCRIPTION="The Jakarta Commons HttpClient provides an efficient, up-to-date, and feature-rich package implementing the client side of the most recent HTTP standards and recommendations."
HOMEPAGE="http://jakarta.apache.org/commons/httpclient/index.html"
SRC_URI="mirror://apache/jakarta/commons/httpclient/source/${MY_P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="~x86 ~ppc"
IUSE="doc junit"

DEPEND=">=virtual/jdk-1.3
	sys-apps/sed
	>=dev-java/log4j-1.2.5
	>=dev-java/ant-1.4
	junit? ( dev-java/junit )
	${RDEPEND}"
RDEPEND=">=virtual/jdk-1.3
		dev-java/commons-logging
		dev-java/commons-codec"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	mkdir lib && cd lib
	java-pkg_jar-from commons-logging
	java-pkg_jar-from commons-codec
	java-pkg_jar-from junit
}

src_compile() {
	local antflags="dist"
	use junit && antflags="${antflags} test"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	use doc && java-pkg_dohtml -r dist/docs/*
}
