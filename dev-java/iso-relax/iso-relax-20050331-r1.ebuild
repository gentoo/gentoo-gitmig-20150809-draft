# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/iso-relax/iso-relax-20050331-r1.ebuild,v 1.7 2006/12/09 09:18:19 flameeyes Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Interfaces useful for applications which support RELAX Core"
HOMEPAGE="http://iso-relax.sourceforge.net"
SRC_URI="mirror://gentoo/${P}-gentoo.tar.bz2"

# To get the build system:
# cvs -d:pserver:anonymous@iso-relax.cvs.sourceforge.net:/cvsroot/iso-relax login
# mkdir iso-relax-20050331
# cd iso-relax-20050331
# cvs -d:pserver:anonymous@iso-relax.cvs.sourceforge.net:/cvsroot/iso-relax -frelease-20050331 co build.xml lib
# rm -r $(find -name CVS)

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE="source"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core"
RDEPEND=">=virtual/jre-1.4"

PATCHES="${FILESDIR}/${P}-build.patch"

src_compile() {
	eant release || die "ant failed"
}

src_install() {
	java-pkg_dojar isorelax.jar
	use source && java-pkg_dosrc src
}
