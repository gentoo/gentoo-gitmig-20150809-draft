# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-attributes/commons-attributes-2.1.ebuild,v 1.2 2005/12/05 14:32:09 nichoj Exp $

inherit eutils java-pkg

DESCRIPTION="Commons Attributes enables Java programmers to use C#/.Net-style attributes in their code."
HOMEPAGE="http://jakarta.apache.org/commons/attributes/"
SRC_URI="mirror://apache/jakarta/commons/attributes/source/${P}-src.tgz"

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="doc jikes source"

# TODO determine jvm version requirements
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )
	dev-java/xjavadoc"
RDEPEND=">=virtual/jre-1.4
	dev-java/xjavadoc"

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}

	epatch ${FILESDIR}/${P}-gentoo.patch

	mkdir -p target/classes/org/apache/commons/attributes
	# This file is missing from upstream's release
	# and is needed to use the ant task.
	cp ${FILESDIR}/anttasks.properties target/classes/org/apache/commons/attributes/

	mkdir -p target/lib
	cd target/lib
	java-pkg_jar-from xjavadoc
}

src_compile() {
	local antflags="jar -Dnoget=true"
	use jikes && antflags="-Dbuild.compiler=jikes ${antflags}"
	use doc && antflags="${antflags} javadoc"

	ant ${antflags} || die "Compilation failed"
}

src_install() {
	java-pkg_newjar target/${PN}-api-${PV}.jar ${PN}-api.jar
	java-pkg_newjar target/${PN}-compiler-${PV}.jar ${PN}-compiler.jar

	dodoc NOTICE.txt RELEASE.txt
	dohtml README.html

	use doc && java-pkg_dohtml -r dist/docs/api
	use source && java-pkg_dosrc */src/java/*
}
