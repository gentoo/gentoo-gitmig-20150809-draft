# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/velocity/velocity-1.4-r1.ebuild,v 1.2 2005/04/02 21:51:56 luckyduck Exp $

inherit java-pkg

DESCRIPTION="A Java-based template engine that allows easy creation/rendering of documents that format and present data."
HOMEPAGE="http://jakarta.apache.org/velocity/"
SRC_URI="mirror://apache/jakarta/velocity/binaries/velocity-${PV}/velocity-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="x86"
IUSE="doc j2ee jikes junit"

DEPEND=">=virtual/jdk-1.3.1"
RDEPEND=">=virtual/jdk-1.3.1
	>=dev-java/ant-1.5.1
	>=dev-java/avalon-logkit-bin-1.2
	=dev-java/jakarta-oro-2.0*
	j2ee? ( =dev-java/sun-j2ee-1.3.1* )
	jikes? ( >=dev-java/jikes-1.17 )"

src_compile () {
	cd ${S}/build
	local antflags
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use junit && antflags="${antflags} test"
	use doc && antflags="${antflags} javadocs"
	if use j2ee ; then
		cp /opt/sun-j2ee-1.3.1/lib/j2ee.jar ${S}/build/lib
		ant ${antflags} jar-J2EE || die "Java compile failed."
	else
		ant ${antflags} jar || die "Java compile failed"
	fi
}


src_install () {
	cd ${S}
	if use j2ee ; then
		java-pkg_dojar bin/${PN}-J2EE-${PV}.jar
	else
		java-pkg_dojar bin/${PN}-${PV}.jar
	fi
	dodoc LICENSE NOTICE README.txt
	use doc && java-pkg_dohtml -r docs/*
}
