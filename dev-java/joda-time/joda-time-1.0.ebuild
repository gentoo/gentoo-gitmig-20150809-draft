# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/joda-time/joda-time-1.0.ebuild,v 1.2 2005/07/16 15:07:19 swegener Exp $

inherit java-pkg

DESCRIPTION="Joda-Time is an open-source project to provide a quality Java date and time API."
HOMEPAGE="http://joda-time.sourceforge.net/"
SRC_URI="mirror://sourceforge/joda-time/${P}-src.tar.gz"
LICENSE="joda"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc jikes"

DEPEND=">=virtual/jdk-1.3
		dev-java/ant
		>=dev-java/ant-1.4
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.3"

src_compile() {
	local antflags="jar -Djunit.jar=$(java-pkg_getjars junit)"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_newjar build/${P}.jar ${PN}.jar
	use doc && java-pkg_dohtml -r build/docs/
}
