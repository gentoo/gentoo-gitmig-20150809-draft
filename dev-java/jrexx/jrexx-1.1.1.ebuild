# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jrexx/jrexx-1.1.1.ebuild,v 1.1 2004/10/30 20:32:43 axxo Exp $

inherit java-pkg

DESCRIPTION="jrexx is a regular expression API for textual pattern matching based on the finite state automaton theory."
SRC_URI="mirror://sourceforge/${PN}/${P}-src.zip"
HOMEPAGE="http://www.karneim.com/jrexx/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RDEPEND="
		>=virtual/jre-1.4
		"
DEPEND=">=virtual/jdk-1.4
		app-arch/unzip
		"
IUSE="doc"
S=${WORKDIR}

src_compile() {
	mkdir build

	cd src
	javac -nowarn -d ${S}/build $(find -name "*.java") \
		|| die "Failed to compile ${i}"

	if use doc ; then
		mkdir ${S}/javadoc
		javadoc -d ${S}/javadoc $(find * -type d | tr '/' '.') \
			|| die "failed to build javadocs"
	fi

	cd ..
	jar cf ${PN}.jar -C build com || die "failed to create jar"
}

src_install() {
	cd ${S}
	java-pkg_dojar ${PN}.jar
	use doc && java-pkg_dohtml -r javadoc
}
