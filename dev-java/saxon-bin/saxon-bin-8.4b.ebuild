# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/saxon-bin/saxon-bin-8.4b.ebuild,v 1.1 2005/07/01 10:05:21 axxo Exp $

inherit java-pkg

DESCRIPTION="The SAXON package is a collection of tools for processing XML documents: XSLT processor, XSL library, parser."
MyPV=${PV%b}
SRC_URI="mirror://sourceforge/saxon/saxonb${MyPV/./-}.zip"
HOMEPAGE="http://saxon.sourceforge.net/"
LICENSE="MPL-1.1"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE="doc"
DEPEND="app-arch/unzip"
RDEPEND="virtual/jdk"
SLOT="0"

S=${WORKDIR}

src_compile() { :; }

src_install() {
	use doc && java-pkg_dohtml -r doc/*
	java-pkg_dojar *.jar
}
