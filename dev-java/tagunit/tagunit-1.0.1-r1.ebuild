# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/tagunit/tagunit-1.0.1-r1.ebuild,v 1.2 2007/01/28 21:10:38 betelgeuse Exp $

inherit java-ant-2 java-pkg-2

DESCRIPTION="TagUnit is a tag library for testing custom tags within JSP pages."
SRC_URI="mirror://sourceforge/${PN}/${P}-src.zip"
HOMEPAGE="http://www.tagunit.org"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="doc source"

RDEPEND="|| ( =virtual/jre-1.3 =virtual/jre-1.4* )
	=dev-java/servletapi-2.4*"

DEPEND=" || ( =virtual/jdk-1.3 =virtual/jdk-1.4* )
	${RDEPEND}
	>=dev-java/ant-core-1.6
	app-arch/unzip
	source? ( app-arch/zip )"

S="${WORKDIR}/${P}-src/tagunit-core"

src_unpack() {
	unpack ${A}
	cd "${S}"

	java-ant_rewrite-classpath
	echo ${PV} > ../version.txt
	mkdir ../lib
}

EANT_BUILD_TARGET="build"
EANT_GENTOO_CLASSPATH="ant-core,servletapi-2.4"

src_install() {
	java-pkg_dojar lib/${PN}.jar
	cd ${S}/..
	dodoc changes.txt readme.txt || die
	use doc && java-pkg_dojavadoc tagunit-core/doc/api
	use source && java-pkg_dosrc tagunit-core/src/*
}
