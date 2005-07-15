# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/picocontainer/picocontainer-1.0_beta4.ebuild,v 1.10 2005/07/15 17:20:19 axxo Exp $

inherit java-pkg

DESCRIPTION="PicoContainer is a lightweight container"
HOMEPAGE="http://docs.codehaus.org/display/PICO/"
SRC_URI="http://dist.codehaus.org/picocontainer/distributions/${PN}-1.0-beta-4-src.tar.gz"
LICENSE="PicoContainer"
SLOT="1"
KEYWORDS="x86 ppc amd64"
IUSE="doc"
RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
		>=dev-java/ant-1.5
		>=dev-java/junit-3.8.1"
S=${WORKDIR}/${PN}-1.0-beta-4

src_unpack() {
	unpack ${A}
	cd ${S}
	# FIXME: patch
	cp ${FILESDIR}/build-${PV}.xml build.xml
	mkdir -p target/lib
	cd target/lib
	java-pkg_jar-from junit junit.jar junit-3.8.1.jar
}

src_compile() {
	ant -Dfinal.name=${PN} jar || die
	if use doc ; then
		ant javadoc || die
	fi
}

src_install() {
	use doc && java-pkg_dohtml -r dist/docs/api
	java-pkg_dojar target/${PN}.jar
}
