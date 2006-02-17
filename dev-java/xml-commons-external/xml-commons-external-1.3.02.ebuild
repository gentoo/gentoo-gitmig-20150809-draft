# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xml-commons-external/xml-commons-external-1.3.02.ebuild,v 1.5 2006/02/17 20:13:19 hansmi Exp $

inherit java-pkg

DESCRIPTION="Thirdparty libraries for xml-commons"
HOMEPAGE="http://xml.apache.org/commons/"
SRC_URI="mirror://gentoo/distfiles/${P}.tar.bz2"
# svn co http://svn.apache.org/repos/asf/xml/commons/tags/xml-commons-external-1_3_02/java/external/ xml-commons-external-1.3.02
# tar cjf xml-commons-external-1.3.02.tar.bz2 xml-commons-external-1.3.02

LICENSE="Apache-2.0"
SLOT="1.3"
KEYWORDS="amd64 ppc x86"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.3
	dev-java/ant-core"
RDEPEND=">=virtual/jre-1.3"

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} -Dbuild.javadocs.dir=build/docs/api"
	ant ${antflags} || die "Compile failed"
}

src_install() {
	java-pkg_dojar build/*.jar
	dodoc NOTICE README.*

	use doc && java-pkg_dohtml -r docs/api
	use source && java-pkg_dosrc src/*
}
