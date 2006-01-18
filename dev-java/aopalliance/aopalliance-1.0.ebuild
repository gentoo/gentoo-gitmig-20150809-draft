# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/aopalliance/aopalliance-1.0.ebuild,v 1.1 2006/01/18 07:19:10 nichoj Exp $

inherit java-pkg

DESCRIPTION="Aspect-Oriented Programming (AOP) Alliance classes"
SRC_URI="mirror://gentoo/${P}-gentoo.tar.bz2"
#SRC_URI="mirror://gentoo/${P}.tar.bz2"
#cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/aopalliance login 
# cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/aopalliance export -r interception_1_0 aopalliance
# rm $(find aopalliance -name CVS)
# tar cjvf aopalliance-1.0-gentoo.tar.bz2 aopalliance
HOMEPAGE="http://aopalliance.sourceforge.net/"
LICENSE="public-domain"
SLOT="1"
KEYWORDS="~amd64 ~x86"
IUSE="doc jikes source"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

src_compile() {
	local antflags="jar"
	use jikes && antflags="-Dbuild.compiler=jikes ${antflags}"
	use doc && antflags="${antflags} javadoc"

	ant ${antflags} || die "ant failed"
}

src_install() {
	java-pkg_dojar build/${PN}.jar
	use doc && java-pkg_dohtml -r build/api
	use source && java-pkg_dosrc src/main
}
