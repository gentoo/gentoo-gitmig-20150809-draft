# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/odmg/odmg-3.0.ebuild,v 1.1 2004/10/30 20:39:36 axxo Exp $

inherit java-pkg

SRC_PN=db-ojb
SRC_PV=1.0.1
SRC_P=${SRC_PN}-${SRC_PV}

DESCRIPTION="The (now obsolete) ODMG 3.0 Java Binding, superceded by JDO."
SRC_URI="mirror://apache/db/ojb/${SRC_P}/${SRC_P}-src.tgz"
HOMEPAGE="http://www.odmg.org"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RDEPEND=">=virtual/jre-1.3"
DEPEND=">=virtual/jdk-1.3
		>=dev-java/ant-core-1.5	"
IUSE="doc jikes"

S=${WORKDIR}/${SRC_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	cp ${FILESDIR}/build-odmg.xml .
	sed -i -r -e "/import/d" -e "s/EnhancedOQL/OQL/g" \
		src/java/org/odmg/Implementation.java
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant -f build-odmg.xml ${antflags} || die "build failed"
}

src_install() {
	java-pkg_dojar dist/odmg.jar
	dodoc LICENSE NOTICE
	use doc && java-pkg_dohtml -r target/javadoc/*
}
