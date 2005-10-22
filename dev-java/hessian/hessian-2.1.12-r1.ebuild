# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/hessian/hessian-2.1.12-r1.ebuild,v 1.1 2005/10/22 20:33:13 betelgeuse Exp $

inherit java-pkg

DESCRIPTION="The Hessian binary web service protocol makes web services usable without requiring a large framework, and without learning yet another alphabet soup of protocols."
HOMEPAGE="http://www.caucho.com/hessian/"
SRC_URI="http://www.caucho.com/hessian/download/${P}-src.jar"

LICENSE="Apache-1.1"
SLOT="2.1"
KEYWORDS="~x86"
IUSE="doc jikes source"

RDEPEND=">=virtual/jre-1.4
		=dev-java/servletapi-2.3*
		=dev-java/caucho-services-${PV}*"
DEPEND=">=virtual/jdk-1.4
		jikes? ( dev-java/jikes )
		source? ( app-arch/zip )
		dev-java/ant-core
		${REDEND}"

src_unpack() {
	jar xvf ${DISTDIR}/${A}

	# We need to move things around a bit
	mkdir -p ${S}/src
	mv com ${S}/src

	rm -fr ${S}/src/com/caucho/services

	cd ${S}
	# No included ant script! Bad Java developer, bad!
	cp ${FILESDIR}/build-${PV}.xml build.xml

	# Populate classpath
	local classpath="classpath=$(java-pkg_getjars servletapi-2.3)"
	classpath="${classpath}:$(java-pkg_getjars caucho-services-2.1)"
	echo ${classpath} >> build.properties
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
