# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jasmin-sable/jasmin-sable-1.2.7.ebuild,v 1.6 2004/10/20 08:37:31 absinthe Exp $

inherit java-pkg

DESCRIPTION="Jasmin packaged with CUP and JAS, maintained by the Sable team"
HOMEPAGE="http://www.sable.mcgill.ca/software/"
SRC_URI="http://www.sable.mcgill.ca/software/jasmin-sable-1.2.7.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE="doc"
DEPEND=">=virtual/jdk-1.3"
RDEPEND=">=virtual/jre-1.3"

src_compile() {
	bin/compile_all.sh || die "Failed to compile"

	# karltk: we may want to split compile_all.sh up if we later on
	# package CUP and JAS separately. aaby@gentoo.org has some ebuilds
	# for this in #46267.

	cd classes
	jar cf jas.jar jas/
	jar cf jasmin.jar jasmin/
	jar cf javacup.jar java_cup/
	jar cf scm.jar scm/
	cd ${S}

	if use doc ; then
		javadoc -d doc `find . -name "*.java"` || die "Failed to build docs"
	fi
}

src_install() {
	java-pkg_dojar classes/{jas,jasmin,javacup,scm}.jar || die "Failed to install jars"

	if use doc ; then
		java-pkg_dohtml -r doc/*
	fi

	dobin ${FILESDIR}/jasmin
}
