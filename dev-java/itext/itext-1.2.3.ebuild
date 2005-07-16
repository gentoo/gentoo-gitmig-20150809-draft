# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/itext/itext-1.2.3.ebuild,v 1.4 2005/07/16 11:59:59 axxo Exp $

inherit java-pkg

DESCRIPTION="A Java library that generate documents in the Portable Document Format (PDF) and/or HTML."
HOMEPAGE="http://www.lowagie.com/iText/"
SRC_URI="http://www.lowagie.com/iText/build.xml
		mirror://sourceforge/itext/${PN}-src-${PV}.tar.gz
		http://itext.sourceforge.net/downloads/iTextHYPH.jar"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc jikes source"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}

src_unpack() {
	mkdir ${WORKDIR}/src && cd ${WORKDIR}/src
	unpack ${PN}-src-${PV}.tar.gz
	cp ${DISTDIR}/build.xml ${WORKDIR}
	cp ${DISTDIR}/iTextHYPH.jar ${WORKDIR}
}

src_compile() {
	local antflags="compileWithXML jarWithXML"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags}
}

src_install() {
	java-pkg_dojar dist/*
	java-pkg_dojar iTextHYPH.jar
	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/com
}
