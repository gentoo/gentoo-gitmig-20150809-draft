# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-httpclient/commons-httpclient-2.0.2-r1.ebuild,v 1.11 2008/01/25 19:56:10 ali_bush Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="The Jakarta Commons HttpClient library"
HOMEPAGE="http://jakarta.apache.org/commons/httpclient/index.html"
SRC_URI="mirror://apache/jakarta/commons/httpclient/source/${P/_/-}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=virtual/jre-1.3
	dev-java/commons-logging"

DEPEND=">=virtual/jdk-1.3
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	#make jikes happy
	#if use jikes; then
	#	sed '837 s/ConnectionPool/org.apache.commons.httpclient.MultiThreadedHttpConnectionManager.ConnectionPool/' \
	#		-i src/java/org/apache/commons/httpclient/MultiThreadedHttpConnectionManager.java \
	#		|| die "failed to sed"
	#fi

	epatch "${FILESDIR}/gentoo.diff"

	#Remove javadoc link tags, they phone home.
	sed -e '/link/ d' -i build.xml || die
	echo "commons-logging.jar=$(java-pkg_getjar commons-logging commons-logging.jar)" >> build.properties
	java-pkg_filter-compiler jikes
}

EANT_BUILD_TARGET="dist"

src_install() {
	java-pkg_dojar dist/${PN}.jar
	use doc && java-pkg_dohtml -r dist/docs/*
	use source && java-pkg_dosrc src/java/*
}
