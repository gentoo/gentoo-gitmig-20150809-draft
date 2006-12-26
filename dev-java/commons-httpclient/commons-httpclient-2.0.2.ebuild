# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-httpclient/commons-httpclient-2.0.2.ebuild,v 1.14 2006/12/26 18:55:26 betelgeuse Exp $

inherit java-pkg eutils

DESCRIPTION="The Jakarta Commons HttpClient library"
HOMEPAGE="http://jakarta.apache.org/commons/httpclient/index.html"
SRC_URI="mirror://apache/jakarta/commons/httpclient/source/${P/_/-}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 x86"
IUSE="doc jikes source"

RDEPEND=">=virtual/jre-1.3
	dev-java/commons-logging"

DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	sys-apps/sed
	>=dev-java/ant-core-1.4
	source? ( app-arch/zip )
	jikes? ( dev-java/jikes )"

src_unpack() {
	unpack ${A}
	cd ${S}

	#make jikes happy
	if use jikes; then
		sed '837 s/ConnectionPool/org.apache.commons.httpclient.MultiThreadedHttpConnectionManager.ConnectionPool/' \
			-i src/java/org/apache/commons/httpclient/MultiThreadedHttpConnectionManager.java \
			|| die "failed to sed"
	fi

	epatch ${FILESDIR}/gentoo.diff || die "patching failed"
	echo "commons-logging.jar=$(java-pkg_getjar commons-logging commons-logging.jar)" >> build.properties
}

src_compile() {
	local antflags="dist"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	use doc && java-pkg_dohtml -r dist/docs/*
	use source && java-pkg_dosrc src/java/*
}
