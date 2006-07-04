# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/c3p0/c3p0-0.9.0_pre6-r1.ebuild,v 1.1 2006/07/04 19:41:56 nichoj Exp $

inherit java-pkg-2 java-ant-2

MY_PV=${PV/_pre/-pre}

DESCRIPTION="c3p0 is a java component to provide an jdbc database pool"
HOMEPAGE="http://c3p0.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.src.tgz"
# Does not like Java 1.6's JDBC API
DEPEND="|| (
		=virtual/jdk-1.3*
		=virtual/jdk-1.4*
		=virtual/jdk-1.5*
	)
	dev-java/ant-core"
RDEPEND=">=virtual/jre-1.3"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

S=${WORKDIR}/${PN}-${MY_PV}.src

ant_src_unpack() {
	unpack ${A}
	cd ${S}
	echo "j2ee.jar.base.dir=${JAVA_HOME}" > build.properties
}

src_compile() {
	eant jar $(use_doc javadocs)
}

src_install() {
	java-pkg_newjar build/${PN}*.jar ${PN}.jar
	dodoc README-SRC
	use doc && java-pkg_dohtml -r build/apidocs/*
}
