# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/saxon/saxon-8.0b.ebuild,v 1.1 2004/06/20 21:09:04 zx Exp $

inherit java-pkg

DESCRIPTION="The SAXON package is a collection of tools for processing XML documents: XSLT processor, XSL library, parser."
SRC_URI="mirror://sourceforge/saxon/saxonb8-0.zip"
HOMEPAGE="http://saxon.sourceforge.net/"
LICENSE="MPL-1.1"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE="doc"
DEPEND=""
RDEPEND="virtual/jdk"
SLOT="0"
RESTRICT="nomirror"

S=${WORKDIR}

src_compile() {
	einfo "This is a binary-only ebuild (for now)."
}

src_install() {
	use doc && dohtml -r doc/*
	java-pkg_dojar *.jar
}
