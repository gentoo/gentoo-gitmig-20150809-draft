# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-httpclient/commons-httpclient-2.0-r1.ebuild,v 1.2 2004/03/23 02:54:11 zx Exp $

inherit java-pkg

DESCRIPTION="The Jakarta Commons HttpClient provides an efficient, up-to-date, and feature-rich package implementing the client side of the most recent HTTP standards and recommendations."
HOMEPAGE="http://jakarta.apache.org/commons/httpclient/index.html"
SRC_URI="mirror://apache/jakarta/commons/httpclient/source/${P/_/-}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/log4j-1.2.5
	>=dev-java/ant-1.4
	dev-java/commons-logging"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE="doc jikes"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd ${S}
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
	use doc && dohtml -r dist/docs/*
}
