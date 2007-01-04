# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xmldb/xmldb-20011111.ebuild,v 1.13 2007/01/04 05:39:42 tgall Exp $

inherit java-pkg eutils

MY_PN="${PN}-api"
MY_PV="11112001"
MY_P="${MY_PN}-${MY_PV}"
DESCRIPTION="Java implementation for specifications made by XML:DB."
HOMEPAGE="http://sourceforge.net/projects/xmldb-org/"
SRC_URI="mirror://sourceforge/xmldb-org/${MY_P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="doc jikes source"

#When someone has the time, please make compiling the junit tests optional
DEPEND=">=virtual/jdk-1.4
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )
	>=dev-java/xerces-2.7
	>=dev-java/xalan-2.7
	dev-java/ant-core
	>=dev-java/junit-3.8"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm *.jar

	epatch ${FILESDIR}/${P}-unreachable.patch

	mkdir src && mv org src
	cp ${FILESDIR}/build-${PVR}.xml build.xml
}

src_compile() {
	local antflags="jar -Dclasspath=$(java-pkg_getjars xerces-2,xalan)"
	use jikes && antflags="-Dbuild.compiler=jikes ${antflags}"
	use doc && antflags="${antflags} javadoc"

	ant ${antflags} || die "Compilation failed"
}

src_install() {
	java-pkg_dojar dist/*.jar

	use doc && java-pkg_dohtml -r dist/doc/api
	use source && java-pkg_dosrc src/*
}
