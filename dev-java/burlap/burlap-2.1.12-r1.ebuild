# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/burlap/burlap-2.1.12-r1.ebuild,v 1.1 2006/07/04 19:33:47 nichoj Exp $

inherit java-pkg-2

DESCRIPTION="The Burlap web service protocol makes web services usable without requiring a large framework, and without learning yet another alphabet soup of protocols."
HOMEPAGE="http://www.caucho.com/burlap/"
SRC_URI="http://www.caucho.com/${PN}/download/${P}-src.jar"

LICENSE="Apache-1.1"
SLOT="2.1"
KEYWORDS="~amd64 ~x86"

IUSE="doc source"

COMMON_DEP="~dev-java/servletapi-2.3"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND="=virtual/jdk-1.4*
	app-arch/unzip
	dev-java/ant-core
	source? ( app-arch/zip )
	${COMMON_DEP}"

src_unpack() {
	mkdir -p ${P}/src
	unzip -qq -d ${S}/src ${DISTDIR}/${A} || die "failed to unpack"

	cd ${S}
	cp ${FILESDIR}/build-${PV}.xml build.xml || die
}

src_compile() {
	eant -Dproject.name=${PN} jar $(use_doc) -lib $(java-pkg_getjar servletapi-2.3 servlet.jar)
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	use doc && java-pkg_dohtml -r dist/doc/api
	use source && java-pkg_dosrc src/*
}
