# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/junit/junit-3.7-r1.ebuild,v 1.2 2002/08/01 18:19:29 karltk Exp $

NP="junit3.7"
S=${WORKDIR}/${NP}
DESCRIPTION="JUnit is a simple framework to write repeatable tests."
SRC_URI="http://download.sourceforge.net/junit/${NP}.zip"
HOMEPAGE="http://JUnit.org"
DEPEND=">=virtual/jdk-1.3"
RDEPEND="$DEPEND"
LICENSE="CPL-0.5"
SLOT="0"
KEYWORDS="x86"

src_unpack() {
	unpack ${NP}.zip
}

src_install () {
	dojar junit.jar src.jar
	dodir /usr/share/ant/lib
	dosym /usr/share/junit/lib/junit.jar /usr/share/ant/lib/
	dohtml -r README.html doc  javadoc
}

