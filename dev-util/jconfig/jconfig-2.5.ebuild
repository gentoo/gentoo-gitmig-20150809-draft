# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/jconfig/jconfig-2.5.ebuild,v 1.3 2004/07/15 17:00:47 mr_bones_ Exp $

inherit java-pkg

DESCRIPTION="jConfig is an extremely helpful utility, providing a simple API for the management of properties."
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-v${PV}.tar.gz"
HOMEPAGE="http://www.jconfig.org/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.3
		>=dev-java/ant-1.4.1
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.3"

S="${WORKDIR}/${PN/c/C}"

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags}
}

src_install() {
	java-pkg_dojar dist/jconfig.jar
	insinto /usr/share/${PN}/lib
	doins lib/*

	echo "#!/bin/sh" > ${PN}
	echo "cd /usr/share/${PN}" >> ${PN}
	echo '${JAVA_HOME}'/bin/java -cp lib/crimson.jar:lib/jaxp.jar:lib/${PN}.jar:.  org/jconfig/gui/JConfig '$*' >> ${PN}
	dobin ${PN}

	use doc && dohtml -r javadoc/*

	dodoc README
}
