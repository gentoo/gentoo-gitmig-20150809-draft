# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/saxon/saxon-6.5.2.ebuild,v 1.1 2003/05/14 06:15:13 absinthe Exp $

inherit java-pkg

S=${WORKDIR}
DESCRIPTION="The SAXON package is a collection of tools for processing XML documents: XSLT processor, XSL library, parser."
SRC_URI="mirror://sourceforge/saxon/saxon${PV//./_}.zip"
HOMEPAGE="http://saxon.sourceforge.net/"
LICENSE="MPL-1.1"
KEYWORDS="x86 sparc ppc"
IUSE="doc"
DEPEND=""
RDEPEND="virtual/jdk"
SLOT="0"

src_compile() {
	einfo "This is a binary-only ebuild (for now)."
}

src_install() {
	use doc && dohtml -r doc/*
	java-pkg_dojar *.jar
}
