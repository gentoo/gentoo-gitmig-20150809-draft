# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/picocontainer/picocontainer-1.0_beta3.ebuild,v 1.1 2004/01/11 04:46:47 karltk Exp $

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="http://www.picocontainer.org"
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
	# FIXME: java-pkg function
	mkdir -p ${S}/target/lib
	(
		cd ${S}/target/lib
		ln -sf /usr/share/ant/lib/ant.jar ant-1.5.jar
		ln -sf /usr/share/ant/lib/ant-optional.jar ant-optional-1.5.jar
		ln -sf /usr/share/ant/lib/junit.jar junit-3.8.1.jar
	)
}

src_compile() {
	ant jar || die
	use doc && ant javadoc || die
}

src_install() {
	dodoc LICENSE.txt
	use doc && ( dohtml -r dist/docs/api )
	dojar target/picocontainer-1.0-SNAPSHOT.jar
}
