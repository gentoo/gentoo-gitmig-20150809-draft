# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/burlap/burlap-3.0.8-r1.ebuild,v 1.5 2006/12/05 01:51:51 caster Exp $

inherit java-pkg-2

DESCRIPTION="The Burlap web service protocol makes web services usable without requiring a large framework, and without learning yet another alphabet soup of protocols."
HOMEPAGE="http://www.caucho.com/burlap/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="Apache-1.1"
SLOT="3.0"
KEYWORDS="amd64 x86"

IUSE="doc source"

COMMON_DEP="
	=dev-java/servletapi-2.3*
	~dev-java/hessian-${PV}
	~dev-java/caucho-services-${PV}"
RDEPEND="=virtual/jre-1.4*
	${COMMON_DEP}"

DEPEND="=virtual/jdk-1.4*
	app-arch/unzip
	dev-java/ant-core
	source? ( app-arch/zip )
	${COMMON_DEP}"

src_compile() {
	eant jar $(use_doc) -Dclasspath=$(java-pkg_getjar servletapi-2.3 servlet.jar):$(java-pkg_getjars hessian-3.0.8,caucho-services-3.0)
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	use doc && java-pkg_dohtml -r dist/doc/api
	use source && java-pkg_dosrc src/*
}
