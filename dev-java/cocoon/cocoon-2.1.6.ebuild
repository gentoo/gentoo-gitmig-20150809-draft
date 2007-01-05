# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cocoon/cocoon-2.1.6.ebuild,v 1.6 2007/01/05 20:24:32 caster Exp $

inherit java-pkg

DESCRIPTION="A Web Publishing Framework for Apache"
HOMEPAGE="http://cocoon.apache.org/"
SRC_URI="mirror://apache/cocoon/${P}-src.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.5.3"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	unpack ${A}

	cd ${S}
	echo "# Gentoo build properties" > local.build.properties
	if ! use doc; then
		echo "exclude.javadocs=true" >> local.build.properties
		echo "exclude.webapp.javadocs=true" >> local.build.properties
		echo "exclude.webapp.documentation=true" >> local.build.properties
		echo "exclude.idldocs=true" >> local.build.properties
		echo "exclude.webapp.idldocs=true" >> local.build.properties
	fi
}

src_compile() {
	sh build.sh war standalone-demo || die
}

src_install() {
	java-pkg_dowar build/${P}/${PN}.war
	java-pkg_dojar build/${P}/cocoon.jar
	java-pkg_jarinto /usr/share/${PN}/lib/core/
	java-pkg_dojar lib/core/*.jar
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
	use doc && java-pkg_dohtml -r build/webapp/api/*
}

pkg_postinst() {
	elog "This ebuild does no longer install the Cocoon webapp into"
	elog "any servlet container anymore. Copy /usr/share/${PN}/webapps/${PN}.war"
	elog "to your servlet container's webapps directory and restart the"
	elog "server."
	echo
	ewarn "Note: To run in Tomcat its version has to be >= 4.0.4"
}
