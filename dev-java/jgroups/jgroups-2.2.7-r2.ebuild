# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jgroups/jgroups-2.2.7-r2.ebuild,v 1.1 2006/08/15 10:01:18 nelchael Exp $

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
	junit? ( dev-java/ant-tasks )"

IUSE="doc junit source"

S=${WORKDIR}/JGroups-${PV}.src

pkg_setup() {
	use junit && ewarn "WARNING: Running unit tests can take a long time."
}

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
	local antflags="compile-1.4 jgroups-core.jar"
	use doc && antflags="${antflags} javadoc"
	use junit && antflags="${antflags} unittests"
	eant ${antflags} || die "build failed"
}

src_install() {
	java-pkg_dojar dist/jgroups-core.jar
	dodoc doc/* CREDITS README

	if use doc ; then
		cd dist
		java-pkg_dohtml -r javadoc
	fi
	use source && java-pkg_dosrc src/*
}
