# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/htmlparser/htmlparser-1.5.20040728.ebuild,v 1.1 2004/10/20 07:56:33 absinthe Exp $

inherit java-pkg

DESCRIPTION="HTML Parser is a Java library used to parse HTML in either a linear or nested fashion."

HOMEPAGE="http://htmlparser.sourceforge.net/"
MY_P=${P/-}
MY_P=${MY_P//./_}
SRC_URI="mirror://sourceforge/htmlparser/${MY_P}.zip"
LICENSE="LGPL-2.1"
SLOT="${PV}"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc"
DEPEND="virtual/jdk
		app-arch/unzip
		dev-java/ant"
#RDEPEND=""

S=${WORKDIR}/${MY_P%_*}

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -rf lib docs
	unzip src.zip
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "failed to compile"
}

src_install() {
	java-pkg_dojar lib/{htmllexer.jar,htmlparser.jar}
	dodoc readme.txt
	use doc && java-pkg_dohtml -r docs/
}
