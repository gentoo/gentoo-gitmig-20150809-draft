# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/hessian/hessian-3.0.8-r2.ebuild,v 1.1 2005/10/23 12:13:39 betelgeuse Exp $

inherit java-pkg

DESCRIPTION="The Hessian binary web service protocol makes web services usable without requiring a large framework, and without learning yet another alphabet soup of protocols."
HOMEPAGE="http://www.caucho.com/hessian/"
SRC_URI="http://www.caucho.com/hessian/download/${P}-src.jar"

LICENSE="Apache-1.1"
SLOT="3.0.8"
KEYWORDS="~x86"
IUSE="doc jikes source"

RDEPEND=">=virtual/jre-1.4
		=dev-java/servletapi-2.3*
		~dev-java/caucho-services-${PV}"

DEPEND=">=virtual/jdk-1.4
		app-arch/unzip
		jikes? ( dev-java/jikes )
		source? ( app-arch/zip )
		dev-java/ant-core
		${RDEPEND}"

src_unpack() {
	mkdir -p ${P}/src
	unzip -qq -d ${S}/src ${DISTDIR}/${A}

	# They package stuff from burlap in here
	# Burlap is a separate protocol
	rm -fr ${S}/src/com/caucho/burlap
	rm -fr ${S}/src/com/caucho/services

	cd ${S}
	# No included ant script! Bad Java developer, bad!
	cp ${FILESDIR}/build-${PV}.xml build.xml

	# Populate classpath
	echo "classpath=$(java-pkg_getjars servletapi-2.3):$(java-pkg_getjars caucho-services-3.0)" >> build.properties
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
