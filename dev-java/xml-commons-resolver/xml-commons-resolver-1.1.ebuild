# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xml-commons-resolver/xml-commons-resolver-1.1.ebuild,v 1.6 2005/01/17 17:09:43 luckyduck Exp $

inherit eutils java-pkg

DESCRIPTION="xml-commons is focussed on common code and guidelines for xml projects."
HOMEPAGE="http://xml.apache.org/commons/"
SRC_URI="mirror://apache/xml/commons/${P}.tar.gz"
DEPEND=">=virtual/jdk-1.3
		dev-java/ant"
RDEPEND=">=virtual/jre-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc source"

src_unpack() {
	unpack ${A}
	cd ${S}

	cp ${FILESDIR}/${P}-build.xml ${S}/build.xml
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} docs"
	use source && antflags="${antflags} sourcezip"
	ant ${antflags} || die "ant build failed"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	dodoc KEYS
	use doc && java-pkg_dohtml -r docs/*

	if use source; then
		dodir /usr/share/doc/${PF}/source/
		cp dist/${PN}-src.zip ${D}/usr/share/doc/${PF}/source/
	fi

}
