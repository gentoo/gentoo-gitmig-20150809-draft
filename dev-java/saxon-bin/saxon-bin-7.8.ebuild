# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/saxon-bin/saxon-bin-7.8.ebuild,v 1.1 2004/07/30 21:46:14 axxo Exp $

inherit java-pkg

DESCRIPTION="The SAXON package is a collection of tools for processing XML documents: XSLT processor, XSL library, parser."
SRC_URI="mirror://sourceforge/saxon/saxon${PV//./-}.zip"
HOMEPAGE="http://saxon.sourceforge.net/"
LICENSE="MPL-1.1"
KEYWORDS="x86 sparc ~ppc"
IUSE="doc"
DEPEND=""
RDEPEND="virtual/jdk"
SLOT="0"

S=${WORKDIR}

src_compile() { :; }

src_install() {
	use doc && dohtml -r doc/*
	java-pkg_dojar *.jar
}
