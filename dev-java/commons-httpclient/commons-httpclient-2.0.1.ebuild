# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-httpclient/commons-httpclient-2.0.1.ebuild,v 1.6 2004/10/17 07:25:42 absinthe Exp $

inherit java-pkg eutils

DESCRIPTION="The Jakarta Commons HttpClient provides an efficient, up-to-date, and feature-rich package implementing the client side of the most recent HTTP standards and recommendations."
HOMEPAGE="http://jakarta.apache.org/commons/httpclient/index.html"
SRC_URI="mirror://apache/jakarta/commons/httpclient/source/${P/_/-}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="doc jikes"

DEPEND=">=virtual/jdk-1.3
	sys-apps/sed
	>=dev-java/log4j-1.2.5
	>=dev-java/ant-1.4
	dev-java/commons-logging"
RDEPEND=">=virtual/jdk-1.3"

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
	echo "commons-logging.jar=/usr/share/commons-logging/lib/commons-logging.jar" >> build.properties
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
}
