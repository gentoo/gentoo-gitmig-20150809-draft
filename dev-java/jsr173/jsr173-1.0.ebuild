# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jsr173/jsr173-1.0.ebuild,v 1.7 2007/01/04 05:51:44 tgall Exp $

inherit java-pkg

DESCRIPTION="The Streaming API for XML (StAX) is a groundbreaking new Java API for parsing and writing XML easily and efficiently"
HOMEPAGE="http://dev2dev.bea.com/xml/stax.html"
SRC_URI="http://ftpna2.bea.com/pub/downloads/${PN}.jar"

LICENSE="bea.ri.jsr173"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="doc jikes source"

RDEPEND=">=virtual/jre-1.3
	dev-java/jaxme"
DEPEND=">=virtual/jdk-1.3
	jikes? ( dev-java/jikes )
	dev-java/ant-core
	${RDEPEND}"

S=${WORKDIR}

src_unpack() {
	cd ${S}
	jar xvf ${DISTDIR}/${A} || die "failed to unpack"

	cp ${FILESDIR}/build-${PVR}.xml build.xml

	jar xvf ${P//-/_}_src.jar || die "failed to unpack"
	rm *.jar
	cd lib
	rm *.jar
	java-pkg_jarfrom jaxme
}

src_compile() {
	local antflags="-Dproject.name=${PN} jar"
	use jikes && antflags="-Dbuild.compiler=jikes ${antflags}"
	use doc && antflags="${antflags} javadoc"

	ant ${antflags} || die "Compilation failed"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	use doc && java-pkg_dohtml -r dist/doc/api
	use source && java-pkg_dosrc src/*
}
