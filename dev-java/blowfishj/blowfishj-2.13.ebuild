# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blowfishj/blowfishj-2.13.ebuild,v 1.1 2004/11/12 00:18:45 karltk Exp $

inherit java-pkg

DESCRIPTION="Blowfish implementation in Java"
SRC_URI="http://www.hotpixel.net/bfj213.zip"
HOMEPAGE="http://come.to/hahn"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
LICENSE="Apache-1.1"
SLOT="0"
IUSE="doc junit"
DEPEND=">=virtual/jre-1.4
		  app-arch/zip"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	unpack ${A}
	mv BlowfishJ blowfishj-2.13
}

src_compile() {
	einfo "Compiling the library"

	for i in BlowfishJ/*.java ; do
		javac -source 1.3 -target 1.2 $i || die "Compile failed for $i"
	done

	if use doc ; then
		javadoc -d doc BlowfishJ/*.java || die "Failed to create docs"
	fi

	einfo "Creating jar"
	jar cvf blowfishj.jar BlowfishJ/*.class || die "Failed creating jar"
}

src_install() {
	java-pkg_dojar blowfishj.jar
	dodoc README.TXT

	if use doc ; then
		java-pkg_dohtml -r docs/html/*
	fi
}
