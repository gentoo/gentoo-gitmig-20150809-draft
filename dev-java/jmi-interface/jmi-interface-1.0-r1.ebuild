# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jmi-interface/jmi-interface-1.0-r1.ebuild,v 1.3 2005/08/15 20:27:35 betelgeuse Exp $

inherit java-pkg

DESCRIPTION="Java Metadata Interface Sample Class Interface"
HOMEPAGE="http://java.sun.com/products/jmi/"
JMI_ZIP="jmi-${PV/./_}-fr-interfaces.zip"
MOF_XML="mof-${PV}.xml.bz2"
SRC_URI="mirror://gentoo/${JMI_ZIP}
		 mirror://gentoo/${MOF_XML}"

LICENSE="sun-bcla-jmi"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="doc jikes source"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}

src_unpack() {
	cp ${FILESDIR}/${P}-build.xml ${S}/build.xml

	mkdir ${S}/src
	unzip -q -d ${S}/src ${DISTDIR}/${JMI_ZIP} || die

	#adding mof.xml required by Netbeans #98603
	unpack ${MOF_XML}

	mkdir -p ${S}/build/javax/jmi/model/resources
	mv mof-${PV}.xml ${S}/build/javax/jmi/model/resources/mof.xml || die
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "Failed to compile"
}

src_install() {
	use doc && java-pkg_dohtml -r doc/*
	use source && java-pkg_dosrc src/*
	java-pkg_dojar dist/*.jar
}
