# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jgoodies-forms/jgoodies-forms-1.0.5.ebuild,v 1.1 2004/12/23 00:43:59 karltk Exp $

inherit java-pkg

DESCRIPTION="JGoodies Forms Library"
HOMEPAGE="http://www.jgoodies.com/"
SRC_URI="http://www.jgoodies.com/download/libraries/forms-1_0_5.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc jikes"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.4
	  app-arch/unzip
	jikes? ( >=dev-java/jikes-1.21 )"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/forms-1.0.5"

src_unpack() {
	unpack ${A}
	cd ${S}

	rm *.jar
	unzip forms-1.0.5-src.zip &> /dev/null || die "Unpack Failed"
	cp ${FILESDIR}/build.xml .
}

src_compile() {
	local antflags="jar"

	if use jikes ; then
		antflags="${antflags} -Dbuild.compiler=jikes"
	fi

	if use doc ; then
		antflags="${antflags} javadoc"
	fi

	ant ${antflags} || die "Compile failed"
}

src_install() {
	java-pkg_dojar forms.jar

	dodoc LICENSE.txt RELEASE-NOTES.txt

	if use doc ; then
		java-pkg_dohtml -r build/doc
	fi
}
