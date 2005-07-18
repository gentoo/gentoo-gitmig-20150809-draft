# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/weka/weka-3.4.3_p20041113.ebuild,v 1.5 2005/07/18 22:07:54 axxo Exp $

inherit eutils java-pkg

DESCRIPTION="A Java data mining package"
SRC_URI="http://dev.gentoo.org/~karltk/projects/java/distfiles/${PN}-20041113.tar.bz2
	http://dev.gentoo.org/~karltk/projects/java/distfiles/${PN}-datasets-20041113.tar.bz2"
HOMEPAGE="http://www.cs.waikato.ac.nz/ml/weka/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~ppc"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core"
#	jikes?( >=dev-java/jikes-1.21 )"
RDEPEND=">=virtual/jre-1.4"
IUSE="doc" # jikes"

S=${WORKDIR}/${PN}-20041113

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}
	mv ${PN}-20041113 ${PN}
	epatch ${FILESDIR}/weka-build_xml.patch
}

src_compile() {
	cd weka

	# all attempts to build it with jikes failed
	local antflags="exejar srcjar remotejar"
	use doc && antflags="${antflags} docs"
#	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "ant build failed"
}

src_install() {
	java-pkg_dojar dist/*.jar

	mkdir bin
	echo "#!/bin/sh" > bin/${PN}
	echo "java -classpath \$(java-config -p weka) weka.gui.GUIChooser" >> bin/${PN}
	dobin bin/${PN}

	use doc && java-pkg_dohtml -r doc/*

	dodir /usr/share/${PN}/data/
	cp -r numeric UCI regression-datasets ${D}/usr/share/${PN}/data \
					|| die "failed to copy datasets"
}
