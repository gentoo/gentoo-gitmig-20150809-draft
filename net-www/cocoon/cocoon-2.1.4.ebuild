# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/cocoon/cocoon-2.1.4.ebuild,v 1.1 2004/03/12 03:16:28 zx Exp $

inherit java-pkg

DESCRIPTION="A Web Publishing Framework for Apache"
HOMEPAGE="http://cocoon.apache.org/"
SRC_URI="mirror://apache/cocoon/${P}-src.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE="doc"
IUSE="doc jikes"

DEPEND=">=virtual/jdk-1.4
		>=dev-java/ant-1.5.3
		jikes? ( >dev-java/jikes-1.18 )"
RDEPEND=">=virtual/jdk-1.4"

src_unpack() {
	unpack ${A}

	cd ${S}
	echo -e "# Gentoo build properties" > local.build.properties
	use jikes && echo -e "compiler=jikes\n" >> local.build.properties
	[ ! `use doc` ] && echo -e "exclude.javadocs=true\n" >> local.build.properties
	[ ! `use doc` ] && echo -e "exclude.webapp.javadocs=true\n" >> local.build.properties
	[ ! `use doc` ] && echo -e "exclude.webapp.documentation=true\n" >> local.build.properties
	[ ! `use doc` ] && echo -e "exclude.idldocs=true\n" >> local.build.properties
	[ ! `use doc` ] && echo -e "exclude.webapp.idldocs=true\n" >> local.build.properties
}

src_compile() {
	sh build.sh war standalone-demo || die
}

src_install() {
	java-pkg_dowar build/${P}/${PN}.war
	java-pkg_dojar build/${P}/cocoon.jar
	JARDESTTREE=lib/core java-pkg_dojar lib/core/*.jar
	insinto /usr/share/${PN}/lib
	doins ${S}/build/${P}/cocoon-*.jar ${S}/lib/jars.xml
	for i in endorsed optional local; do
		dodir /usr/share/${PN}/lib/${i}
		insinto /usr/share/${PN}/lib/${i}
		doins ${S}/lib/${i}/*
	done

	dodoc CREDITS.txt INSTALL.txt KEYS README.txt
	docinto legal
	dodoc legal/*

	docinto api
	use doc && dohtml -r build/webapp/api/*
}

pkg_postinst() {
	einfo "This ebuild does no longer install the Cocoon webapp into"
	einfo "any servlet container anymore. Copy /usr/share/${PN}/webapps/${PN}.war"
	einfo "to your servlet container's webapps directory and restart the"
	einfo "server."
	einfo
	ewarn "Note: To run in Tomcat its version has to be >= 4.0.4"
}
