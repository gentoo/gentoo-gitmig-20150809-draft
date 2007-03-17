# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jgroups/jgroups-2.2.7-r2.ebuild,v 1.3 2007/03/17 13:13:53 betelgeuse Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="JGroups is a toolkit for reliable multicast communication."
SRC_URI="mirror://sourceforge/javagroups/JGroups-${PV}.src.zip"
HOMEPAGE="http://www.jgroups.org/javagroupsnew/docs/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
RDEPEND=">=virtual/jre-1.4
	dev-java/bsh
	dev-java/commons-logging
	dev-java/log4j
	dev-java/junit
	dev-java/concurrent-util
	dev-java/sun-jms"

DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	>=dev-java/ant-core-1.5
	app-arch/unzip
	source? ( app-arch/zip )"
#test? ( dev-java/ant )

IUSE="doc source"

S=${WORKDIR}/JGroups-${PV}.src

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	rm *.jar

	java-pkg_jar-from bsh
	java-pkg_jar-from commons-logging
	java-pkg_jar-from concurrent-util
	java-pkg_jar-from sun-jms
	java-pkg_jar-from log4j

	# Needed for compile, not only for tests:
	java-pkg_jar-from junit

	# Removing so it doesn't get installed with all the other files
	rm ${S}/doc/LICENSE
}

src_compile() {
	eant compile-1.4 jgroups-core.jar $(use_doc)
}

src_install() {
	java-pkg_dojar dist/jgroups-core.jar
	dodoc doc/* CREDITS README || die

	use doc && java-pkg_dojavadoc dist/javadoc
	use source && java-pkg_dosrc src/*
}

RESTRICT="test"
# A lot of these fail
src_test() {
	eant unittests
}
