# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/velocity/velocity-1.4.ebuild,v 1.2 2004/07/30 18:44:33 axxo Exp $

DESCRIPTION="A Java-based template engine that allows easy creation/rendering of documents that format and present data."
HOMEPAGE="http://jakarta.apache.org/velocity/"
SRC_URI="mirror://apache/jakarta/velocity/binaries/velocity-${PV}/velocity-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc j2ee jikes junit"

DEPEND=">=dev-java/sun-jdk-1.3.1"
RDEPEND=">=dev-java/sun-jdk-1.3.1
	>=dev-java/ant-1.5.1
	>=dev-java/avalon-logkit-bin-1.2
	>=dev-java/oro-2.0.6
	j2ee? ( =dev-java/sun-j2ee-1.3.1* )
	jikes? ( >=dev-java/jikes-1.17 )"

src_compile () {
	cd ${S}/build
	local antflags
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use junit && antflags="${antflags} test"
	if use j2ee ; then
		cp /opt/sun-j2ee-1.3.1/lib/j2ee.jar ${S}/build/lib
		ant ${antflags} jar-J2EE || die "Java compile failed."
	else
		ant ${antflags} jar || die "Java compile failed"
	fi

	use doc && ant javadocs || die "Document compile failed"
}

src_install () {
	cd ${S}
	if use j2ee ; then
		dojar bin/${PN}-J2EE-${PV}.jar
	else
		dojar bin/${PN}-${PV}.jar
	fi
	dodoc LICENSE NOTICE README.txt
	use doc && dohtml -r docs/*
}
