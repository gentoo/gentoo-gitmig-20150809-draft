# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/radeox/radeox-1.0_beta2.ebuild,v 1.7 2005/03/29 16:18:19 luckyduck Exp $

inherit java-pkg

DESCRIPTION="Radeox Wiki render engine"
HOMEPAGE="http://www.radeox.org"
SRC_URI="ftp://snipsnap.org/radeox/${PN}-1.0-BETA-2-src.tgz"
LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.4
	=dev-java/jakarta-oro-2.0*
	=dev-java/junit-3.8*
	=dev-java/picocontainer-1.0*
	=dev-java/commons-logging-1.0*"
# karltk: is junit really necessary?
S=${WORKDIR}/${PN}-1.0-BETA-2

src_unpack() {
	unpack ${A}

	rm -f ${S}/lib/*.jar
	(
		cd ${S}/lib
		java-pkg_jar-from junit
		java-pkg_jar-from jakarta-oro-2.0 jakarta-oro.jar oro.jar
		java-pkg_jar-from commons-logging
		java-pkg_jar-from picocontainer-1

	)
	rm -rf  ${S}/src/org/radeox/example/ \
		${S}/src/test/ \
		${S}/src/org/radeox/test/
}

src_compile() {
	local antflags="jar jar-api"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	dodoc Changes.txt README Radeox.version license.txt
	use doc && java-pkg_dohtml -r docs/api
	java-pkg_dojar lib/{radeox,radeox-api}.jar
}
