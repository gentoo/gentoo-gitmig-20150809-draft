# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xmldb/xmldb-20011111-r1.ebuild,v 1.5 2006/12/09 09:26:20 flameeyes Exp $

inherit java-pkg-2 eutils java-ant-2

MY_PN="${PN}-api"
MY_PV="11112001"
MY_P="${MY_PN}-${MY_PV}"
DESCRIPTION="Java implementation for specifications made by XML:DB."
HOMEPAGE="http://sourceforge.net/projects/xmldb-org/"
SRC_URI="mirror://sourceforge/xmldb-org/${MY_P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="doc source"

# TODO please make compiling the junit tests optional
DEPEND=">=virtual/jdk-1.4
	source? ( app-arch/zip )
	>=dev-java/xerces-2.7
	>=dev-java/xalan-2.7
	dev-java/ant-core
	=dev-java/junit-3.8*"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm *.jar
	mkdir lib

	epatch ${FILESDIR}/${P}-unreachable.patch

	mkdir src && mv org src
	cp ${FILESDIR}/build-${PV}.xml build.xml
}

src_compile() {
	eant jar $(use_doc) -Dclasspath=$(java-pkg_getjars xerces-2,xalan,junit)
}

src_install() {
	java-pkg_dojar dist/*.jar

	use doc && java-pkg_dohtml -r dist/doc/api
	use source && java-pkg_dosrc src/*
}
