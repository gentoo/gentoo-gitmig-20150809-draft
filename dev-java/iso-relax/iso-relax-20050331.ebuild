# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/iso-relax/iso-relax-20050331.ebuild,v 1.1 2006/01/18 07:15:40 nichoj Exp $

inherit java-pkg base

DESCRIPTION="Interfaces usefull for applications which support RELAX Core"
HOMEPAGE="http://iso-relax.sourceforge.net"
SRC_URI="mirror://gentoo/${P}-gentoo.tar.bz2"
#  cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/iso-relax login 
# mkdir iso-releax-20050331
# cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/iso-relax -frelease-20050331 co build.xml lib
# rm -r $(find -name CVS)

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core"
RDEPEND=">=virtual/jre-1.4"

PATCHES="${FILESDIR}/${P}-build.patch"

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"

	ant ${antflags} || die "ant failed"
}

src_install() {
	java-pkg_dojar isorelax.jar

	use doc && java-pkg_dohtml -r docs/api
	use source && java-pkg_dosrc src
}
