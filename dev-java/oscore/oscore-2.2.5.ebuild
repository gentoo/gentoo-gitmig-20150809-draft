# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/oscore/oscore-2.2.5.ebuild,v 1.3 2006/03/19 22:18:06 halcy0n Exp $

inherit java-pkg eutils

DESCRIPTION="A set of utility-classes useful in any J2EE application"
HOMEPAGE="http://www.opensymphony.com/oscore/"
SRC_URI="https://${PN}.dev.java.net/files/documents/725/17892/${P}.zip"

LICENSE="OpenSymphony-1.1"
SLOT="2.2"
KEYWORDS="~amd64 ~x86"
IUSE="doc source"

LIB_DEPS="
	~dev-java/servletapi-2.2
	=dev-java/gnu-javamail-1*
	=dev-java/crimson-1*
	dev-java/commons-logging
	dev-java/log4j
	dev-java/sun-ejb-spec
	=dev-java/ognl-2.6*
	dev-java/xdoclet"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.6
	>=dev-java/ant-tasks-1.6
	app-arch/unzip
	${LIB_DEPS}"
RDEPEND=">=virtual/jre-1.4
	${LIB_DEPS}"


S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Disables jalopy stuff
	epatch ${FILESDIR}/${P}-build.patch

	cp ${FILESDIR}/osbuild.xml .
	touch ${S}/EMPTY.MF

	mkdir -p lib/core
	cd lib/core
	rm *.jar
	java-pkg_jar-from servletapi-2.2
	java-pkg_jar-from gnu-javamail-1 gnumail.jar mail.jar
	java-pkg_jar-from crimson-1
	java-pkg_jar-from commons-logging
	java-pkg_jar-from log4j
	java-pkg_jar-from sun-ejb-spec ejb-api.jar ejb.jar
	java-pkg_jar-from ognl-2.6

	cd ../build
	rm -f *.jar jalopy/*.jar
	cd xdoclet
	java-pkg_jar-from xdoclet
}

src_compile() {
	local antflags="jar -Dcommon.build=${S}/osbuild.xml"
	use doc && antflags="${antflags} javadocs"
	ant ${antflags} || die "ant failed"
}

src_install() {
	java-pkg_newjar build/${P}.jar ${PN}.jar

	use doc && java-pkg_dohtml -r dist/docs/api
	use source && java-pkg_dosrc src/java/*
}
