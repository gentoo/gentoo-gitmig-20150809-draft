# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/itext/itext-1.02b-r1.ebuild,v 1.1 2004/11/14 10:59:04 axxo Exp $

inherit java-pkg

DESCRIPTION="A Java library that generate documents in the Portable Document Format (PDF) and/or HTML."
HOMEPAGE="http://www.lowagie.com/iText/"
SRC_URI="http://www.lowagie.com/iText/build.xml
		mirror://sourceforge/itext/${PN}-src-${PV}.tar.gz
		mirror://sourceforge/itext/${PN}-xml-src-1.02.tar.gz"

IUSE="doc jikes"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=virtual/jdk-1.2
	>=dev-java/ant-1.4
	dev-java/sun-j2ee
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.2"

S=${WORKDIR}

src_unpack() {
	mkdir ${WORKDIR}/src && cd ${WORKDIR}/src
	unpack ${PN}-src-${PV}.tar.gz
	unpack ${PN}-xml-src-1.02.tar.gz
	cp ${DISTDIR}/build.xml ${WORKDIR}
}

src_compile() {
	[ -z $J2EE_HOME ] && export J2EE_HOME="/opt/sun-j2ee-1.3.1"
	echo J2EE_HOME=${J2EE_HOME}
	local antflags="jarWithXML"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags}
}

src_install() {
	java-pkg_dojar dist/*
	use doc && java-pkg_dohtml -r docs/*
}
