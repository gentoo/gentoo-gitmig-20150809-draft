# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blowfishj/blowfishj-2.14.ebuild,v 1.5 2006/10/05 15:11:33 gustavoz Exp $

inherit java-pkg

DESCRIPTION="Blowfish implementation in Java"
SRC_URI="mirror://sourceforge/blowfishj/${P}-src.tar.gz"
HOMEPAGE="http://blowfishj.sourceforge.net/index.html"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="x86 amd64 ppc"
IUSE="doc junit"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant
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
