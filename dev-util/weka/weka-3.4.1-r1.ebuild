# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/weka/weka-3.4.1-r1.ebuild,v 1.3 2004/11/03 11:49:42 axxo Exp $

inherit java-pkg

DESCRIPTION="A Java data mining package"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV//./-}.zip"
HOMEPAGE="http://www.cs.waikato.ac.nz/ml/weka/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
DEPEND=">=virtual/jdk-1.4.1
		app-arch/unzip"
IUSE="doc"

S=${WORKDIR}/${PN}-3-4


src_unpack() {
	unpack ${A}
	cd ${S}
	mkdir build
	jar xf weka.jar || die "failed to unpack"

	find weka/ -type f -name '*.class' -exec rm -f {} \; || die "failed to	remove classes"
	cp -r weka build || die "failed to copy"

	rm -rf weka
	jar xf weka-src.jar || die "failed to unpack"

	rm -f *.jar
}

src_compile() {
	javac -nowarn -classpath . $(find weka -name '*.java') -d build || die "failed to compile"
	jar cf ${PN}.jar -C build .
}

src_install() {
	java-pkg_dojar ${PN}.jar || die "failed installing"

	mkdir bin
	echo "#!/bin/sh" > bin/${PN}
	echo "java -classpath \$(java-config -p weka) weka.gui.GUIChooser" >> bin/${PN}
	dobin bin/${PN}

	dodir /usr/share/${PN}/data/
	cp data/* ${D}/usr/share/${PN}/data/ || die "failed to copy data"
	use doc && java-pkg_dohtml -r doc/*
	dodoc README* COPYING CHANGELOG-${PV//./-}
	cp *.pdf ${D}/usr/share/doc/${PF}/ || die "failed to copy docs"
}
