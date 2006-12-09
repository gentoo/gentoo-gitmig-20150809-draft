# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jsr173/jsr173-1.0-r1.ebuild,v 1.3 2006/12/09 09:21:47 flameeyes Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="The Streaming API for XML (StAX) is a groundbreaking new Java API for parsing and writing XML easily and efficiently"
HOMEPAGE="http://dev2dev.bea.com/xml/stax.html"
SRC_URI="http://ftpna2.bea.com/pub/downloads/${PN}.jar"

LICENSE="bea.ri.jsr173"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="doc source"

RDEPEND=">=virtual/jre-1.3
	dev-java/jaxme"
DEPEND=">=virtual/jdk-1.3
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
	use doc && antflags="${antflags} javadoc"

	eant ${antflags} || die "Compilation failed"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	use doc && java-pkg_dohtml -r dist/doc/api
	use source && java-pkg_dosrc src/*
}
