# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/icu4j/icu4j-3.0.ebuild,v 1.4 2004/10/20 08:24:17 absinthe Exp $

inherit java-pkg

DESCRIPTION="International Components for Unicode for Java"

HOMEPAGE="http://oss.software.ibm.com/icu4j/"
MY_PV=${PV/./_}
SRC_URI="ftp://www-126.ibm.com/pub/icu4j/${PV}/${PN}src_${MY_PV}.jar
		doc? ( ftp://www-126.ibm.com/pub/icu4j/${PV}/${PN}docs_${MY_PV}.jar )"
LICENSE="icu"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc"
DEPEND=">=virtual/jdk-1.4
		dev-java/ant"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}

src_unpack() {
	jar -xf ${DISTDIR}/${PN}src_${MY_PV}.jar
	if use doc; then
		mkdir docs; cd docs
		jar -xf ${DISTDIR}/${PN}docs_${MY_PV}.jar
	fi
}

src_compile() {
	local antflags="jar"
	ant ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_dojar ${PN}.jar

	use doc && java-pkg_dohtml -r readme.html docs/*
}
