# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blowfishj/blowfishj-2.14.ebuild,v 1.1 2005/04/03 14:01:17 axxo Exp $

inherit java-pkg

DESCRIPTION="Blowfish implementation in Java"
SRC_URI="mirror://sourceforge/blowfishj/${P}-src.tar.gz"
HOMEPAGE="http://blowfishj.sourceforge.net/index.html"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
LICENSE="Apache-2.0"
SLOT="0"
IUSE="doc junit"
DEPEND=">=virtual/jre-1.4
		  app-arch/unzip
		  junit? ( dev-java/junit ) "
RDEPEND=">=virtual/jre-1.4"

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use junit && antflags="${antflags} test"

	ant ${antflags} || die "failed to compile"
}

src_install() {
	mv target/${P}.jar ${PN}.jar
	java-pkg_dojar ${PN}.jar

	use doc && java-pkg_dohtml -r dist/docs/api/*
}
