# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-primitives/commons-primitives-1.0-r2.ebuild,v 1.1 2006/07/22 23:04:39 nelchael Exp $

inherit java-pkg-2

DESCRIPTION="The Jakarta-Commons Primitives Component"
HOMEPAGE="http://jakarta.apache.org/commons/primitives/"
SRC_URI="mirror://apache/jakarta/commons/primitives/source/${P}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	dev-java/ant-core"
RDEPEND=">=virtual/jre-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc source"

src_compile() {
	local antflags="compile"
	use doc && antflags="${antflags} javadoc"
	eant ${antflags} jar || die "compile problem"
}

src_install() {
	java-pkg_newjar target/${P}.jar ${PN}.jar

	use doc && java-pkg_dohtml -r target/docs/api/*
	use source && java-pkg_dosrc src/java/*
}
