# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/junit/junit-3.8.1.ebuild,v 1.1 2002/10/14 17:46:44 karltk Exp $

NP=${P/-/}
S=${WORKDIR}/${NP}
DESCRIPTION="JUnit is a simple framework to write repeatable tests."
SRC_URI="http://download.sourceforge.net/junit/${NP}.zip"
HOMEPAGE="http://JUnit.org"
DEPEND=">=virtual/jdk-1.3"
RDEPEND="$DEPEND"
LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	unzip src.jar
}

src_compile() {
	rm junit.jar
	ant
}

src_install () {
	cd ${NP}
	dojar junit.jar
	dodir /usr/share/ant/lib
	dosym /usr/share/junit/lib/junit.jar /usr/share/ant/lib/
	dohtml -r README.html cpl-v10.html doc  javadoc
}

