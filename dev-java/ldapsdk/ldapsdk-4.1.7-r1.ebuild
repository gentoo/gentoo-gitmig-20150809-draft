# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ldapsdk/ldapsdk-4.1.7-r1.ebuild,v 1.2 2005/04/02 21:46:35 luckyduck Exp $

inherit eutils java-pkg

DESCRIPTION="Netscape Directory SDK for Java"
HOMEPAGE="http://www.mozilla.org/directory/javasdk.html"
SRC_URI="http://www.mozilla.org/directory/${PN}_java_20020819.tar.gz"

LICENSE="MPL-1.1"
SLOT="4.1"
KEYWORDS="x86 amd64 ~sparc"
IUSE="doc"

S=${WORKDIR}/mozilla/directory/java-sdk

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.6.2"
RDEPEND=">=virtual/jre-1.4
	=dev-java/jss-3.4*
	=dev-java/jakarta-oro-2.0*"

src_unpack() {
	unpack ${A}

	cd ${WORKDIR}/mozilla
	epatch ${FILESDIR}/ldapsdk-gentoo.patch

	cd ${S}
	echo "ororegexp.jar=`java-config -p jakarta-oro-2.0`" > build.properties
	echo "jss.jar=`java-config -p jss-3.4`" >> build.properties

	cd ${S}/ldapjdk/lib
	rm -f *.jar
	java-pkg_jar-from jss-3.4

	cd ${S}/ldapsp/lib
	rm *.jar
}

src_compile() {
	local antflags="dist-jdk dist-filter dist-beans dist-jndi"
	use doc && antflags="${antflags} build-docs"
	ant ${antflags} || die "compile failed"
}

src_install () {
	java-pkg_dojar dist/packages/*.jar

	use doc && java-pkg_dohtml -r dist/doc/*
}
