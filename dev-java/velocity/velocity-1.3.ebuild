# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/velocity/velocity-1.3.ebuild,v 1.10 2004/07/30 18:44:33 axxo Exp $

DESCRIPTION="A Java-based template engine that allows easy creation/rendering of documents that format and present data."
HOMEPAGE="http://jakarta.apache.org/velocity/"
SRC_URI="http://jakarta.apache.org/builds/jakarta-${PN}/release/v${PV}/${PN}-${PV}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86"
IUSE="doc j2ee jikes"

DEPEND=">=dev-java/sun-jdk-1.3.1"
RDEPEND=">=dev-java/sun-jdk-1.3.1
	>=dev-java/ant-1.5.1
	>=dev-java/avalon-logkit-bin-1.2
	>=dev-java/oro-2.0.6
	j2ee? ( =dev-java/sun-j2ee-1.3.1* )
	jikes? ( >=dev-java/jikes-1.17 )"

src_compile () {
	cd ${S}/build
	local myc
	if use jikes ; then
		myc="${myc} -Dbuild.compiler=jikes"
	fi

	if use j2ee ; then
		cp /opt/sun-j2ee-1.3.1/lib/j2ee.jar ${S}/build/lib
		ANT_OPTS=${myc} ant jar-J2EE || die "Java compile failed."
	else
		ANT_OPTS=${myc} ant jar || die "Java compile failed"
	fi

	if use doc ; then
		ant javadocs || die "Document compile failed"
	fi
}

src_install () {
	cd ${S}
	if use j2ee ; then
		dojar bin/${PN}-J2EE-${PV}.jar
	else
		dojar bin/${PN}-${PV}.jar
	fi
	dodoc LICENSE.txt README.txt
	use doc && dohtml -r docs/*
}
