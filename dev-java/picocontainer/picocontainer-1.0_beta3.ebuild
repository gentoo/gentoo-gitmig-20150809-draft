# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/picocontainer/picocontainer-1.0_beta3.ebuild,v 1.3 2004/04/10 15:22:30 zx Exp $

inherit java-pkg

DESCRIPTION="http://docs.codehaus.org/display/PICO/"
HOMEPAGE="http://docs.codehaus.org/display/PICO/"
SRC_URI="http://dist.codehaus.org/picocontainer/distributions/${PN}-1.0-beta-3-src.tar.gz"
LICENSE="PicoContainer"
SLOT="1"
KEYWORDS="~x86"
IUSE="doc"
DEPEND="=dev-java/ant-1.5*
	=dev-java/junit-3.8.1"
S=${WORKDIR}/${PN}-1.0-beta-3

src_unpack() {
	unpack ${A}
	# FIXME: patch
	cp ${FILESDIR}/build-${PV}.xml ${S}/build.xml
	mkdir -p ${S}/target/lib
	(
		cd ${S}/target/lib
		java-pkg_jar-from ant ant.jar ant-1.5.jar
		java-pkg_jar-from ant ant-optional.jar ant-optional-1.5.jar
		java-pkg_jar-from junit junit.jar junit-3.8.1.jar
	)
}

src_compile() {
	ant jar || die
	if (use doc) ; then
		ant javadoc || die
	fi
	cp target/picocontainer-1.0-SNAPSHOT.jar \
		target/picocontainer-1.0.jar
}

src_install() {
	dodoc LICENSE.txt
	use doc && ( dohtml -r dist/docs/api )
	dojar target/picocontainer-1.0.jar
}
