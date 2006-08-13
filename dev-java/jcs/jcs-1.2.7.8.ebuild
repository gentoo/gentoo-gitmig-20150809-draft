# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jcs/jcs-1.2.7.8.ebuild,v 1.1 2006/08/13 11:42:47 nelchael Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="JCS is a distributed caching system written in java for server-side java applications"
HOMEPAGE="http://jakarta.apache.org/jcs/"
# Yes, it's a checkout from JCS SVN...
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="1.2"
KEYWORDS="~amd64 ~x86"
IUSE="doc source"

COMMON_DEPEND="dev-java/jgroups
	=dev-java/servletapi-2.3*
	dev-java/commons-lang
	dev-java/commons-logging
	dev-java/commons-pool
	dev-java/commons-dbcp
	dev-java/xmlrpc
	dev-java/concurrent-util
	dev-java/velocity
	=dev-java/jisp-2.5*
	=dev-java/struts-1.1*
	dev-db/hsqldb"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	source? ( app-arch/zip )
	${COMMON_DEPEND}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEPEND}"

LIBRARY_PKGS="jgroups,servletapi-2.3,commons-lang,commons-logging,commons-pool,commons-dbcp,xmlrpc,concurrent-util,velocity,jisp-2.5,struts-1.1,hsqldb"

src_unpack() {
	unpack ${A}

	cd "${S}"

	# use our own build.xml because jcs's is demented by maven
	cp "${FILESDIR}/build-${PV}.xml" build.xml

	cat > build.properties <<-END
		classpath=$(java-pkg_getjars ${LIBRARY_PKGS})
	END
}

src_compile() {
	eant jar -Dproject.name=${PN} $(use_doc)
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	use doc && java-pkg_dohtml -r dist/doc/api
	use source && java-pkg_dosrc src/java/*
}
