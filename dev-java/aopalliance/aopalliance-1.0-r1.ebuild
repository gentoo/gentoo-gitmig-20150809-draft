# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/aopalliance/aopalliance-1.0-r1.ebuild,v 1.2 2006/07/02 05:01:54 nichoj Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Aspect-Oriented Programming (AOP) Alliance classes"
SRC_URI="mirror://gentoo/${P}-gentoo.tar.bz2"
#SRC_URI="mirror://gentoo/${P}.tar.bz2"
# Tarball creation:
# cvs -d:pserver:anonymous@aopalliance.cvs.sourceforge.net:/cvsroot/aopalliance login 
# cvs -z3 -d:pserver:anonymous@aopalliance.cvs.sourceforge.net:/cvsroot/aopalliance export -r interception_1_0 aopalliance
# tar cjvf aopalliance-1.0-gentoo.tar.bz2 aopalliance
HOMEPAGE="http://aopalliance.sourceforge.net/"
LICENSE="public-domain"
SLOT="1"
KEYWORDS="~amd64 ~x86"
IUSE="doc source"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

src_compile() {
	eant jar $(use_doc) 
}

src_install() {
	java-pkg_dojar build/${PN}.jar
	use doc && java-pkg_dohtml -r build/api
	use source && java-pkg_dosrc src/main
}
