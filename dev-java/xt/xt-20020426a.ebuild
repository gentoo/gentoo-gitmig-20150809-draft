# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xt/xt-20020426a.ebuild,v 1.2 2004/05/26 14:48:18 zx Exp $

inherit java-pkg

DESCRIPTION="Java Implementation of XSL-Transformations"
SRC_URI="ftp://ftp.jclark.com/pub/xml/${PN}.zip
	ftp://ftp.jclark.com/pub/xml/xp.zip"
HOMEPAGE="http://www.blnz.com/xt/"
LICENSE="JamesClark"
SLOT="0"
KEYWORDS="x86"
DEPEND=">=virtual/jdk-1.2.2"
IUSE="doc"
RESTRICT="nomirror"

S=${WORKDIR}

src_compile() { :; }

src_install() {
	java-pkg_dojar *.jar
	dohtml xt.html
	use doc && dohtml -r demo/* && dohtml -r docs/*
}



