# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/joda-time/joda-time-1.2.ebuild,v 1.1 2005/12/23 04:16:27 nichoj Exp $

inherit java-pkg

MY_P="${P}-src"

DESCRIPTION="An open-source project to provide a quality Java date and time API."
HOMEPAGE="http://joda-time.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="joda"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

DEPEND=">=virtual/jdk-1.3
		>=dev-java/ant-1.4
		dev-java/junit"
RDEPEND=">=virtual/jre-1.3"

S="${WORKDIR}/${MY_P}"

src_compile() {
	local antflags="jar -Djunit.jar=$(java-pkg_getjars junit)"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_newjar build/${P}.jar ${PN}.jar
	use doc && java-pkg_dohtml -r build/docs/
}
