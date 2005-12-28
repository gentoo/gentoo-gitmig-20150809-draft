# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/picocontainer/picocontainer-1.0_beta4.ebuild,v 1.11 2005/12/28 02:34:50 nichoj Exp $

inherit java-pkg

MY_PV="${PV/_beta/-beta-}"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="PicoContainer is a lightweight container"
HOMEPAGE="http://docs.codehaus.org/display/PICO/"
SRC_URI="http://dist.codehaus.org/${PN}/distributions/${MY_P}-src.tar.gz"
LICENSE="PicoContainer"
SLOT="1"
KEYWORDS="x86 ppc amd64"
IUSE="doc"
RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
		>=dev-java/ant-1.5
		>=dev-java/junit-3.8.1"
S="${WORKDIR}/${MY_P}"

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
	local antflags="-Dfinal.name=${PN} jar"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die
}

src_install() {
	use doc && java-pkg_dohtml -r dist/docs/api
	java-pkg_dojar target/${PN}.jar
}
