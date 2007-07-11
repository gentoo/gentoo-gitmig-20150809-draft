# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jakarta-slide-webdavclient/jakarta-slide-webdavclient-2.1-r1.ebuild,v 1.2 2007/07/11 19:58:38 mr_bones_ Exp $

inherit eutils java-pkg-2 java-ant-2

MY_P="${PN}-src-${PV}"
DESCRIPTION="! Slide is a content repository which can serve as a basis for a content management system / framework and other purposes"
HOMEPAGE="http://jakarta.apache.org/slide/index.html"
SRC_URI="http://archive.apache.org/dist/jakarta/slide/source/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc source"

RDEPEND=">=virtual/jre-1.4
	dev-java/antlr
	=dev-java/commons-httpclient-2.0*
	dev-java/commons-logging
	dev-java/commons-transaction
	~dev-java/jdom-1.0
	dev-java/xml-im-exporter"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch

	cd ${S}/lib
	java-pkg_jar-from antlr
	java-pkg_jar-from commons-httpclient
	java-pkg_jar-from commons-logging
	java-pkg_jar-from commons-transaction
	java-pkg_jar-from jdom-1.0
	java-pkg_jar-from xml-im-exporter
}

EANT_BUILD_TARGET="dist-clientlib"
EANT_DOC_TARGET="javadoc-clientlib"

src_install() {
	java-pkg_newjar dist/lib/${P/client/lib}.jar ${PN/client/lib}.jar

	dodoc README
	use doc && java-pkg_dojavadoc build/doc/clientjavadoc/
	use source && java-pkg_dosrc \
		clientlib/src/java/* \
		ant/src/java/* \
		commandline/src/java/* \
		connector/src/java/*
}
