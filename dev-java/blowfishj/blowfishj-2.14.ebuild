# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blowfishj/blowfishj-2.14.ebuild,v 1.3 2005/07/16 14:50:28 axxo Exp $

inherit java-pkg

DESCRIPTION="Blowfish implementation in Java"
SRC_URI="mirror://sourceforge/blowfishj/${P}-src.tar.gz"
HOMEPAGE="http://blowfishj.sourceforge.net/index.html"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="x86 amd64 ppc ~sparc"
IUSE="doc junit"

DEPEND=">=virtual/jdk-1.4
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
	java-pkg_newjar target/${P}.jar ${PN}.jar

	use doc && java-pkg_dohtml -r dist/docs/api/*
}
