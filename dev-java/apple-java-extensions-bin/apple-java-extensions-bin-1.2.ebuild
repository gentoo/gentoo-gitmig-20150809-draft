# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/apple-java-extensions-bin/apple-java-extensions-bin-1.2.ebuild,v 1.2 2004/08/03 11:31:13 dholm Exp $

inherit java-pkg

DESCRIPTION="This is a pluggable jar of stub classes representing the new Apple eAWT and eIO APIs for Java 1.4 on Mac OS X. The purpose of these stubs is to allow for compilation of eAWT- or eIO-referencing code on platforms other than Mac OS X"
HOMEPAGE="http://developer.apple.com/samplecode/AppleJavaExtensions/AppleJavaExtensions.html"
SRC_URI="http://developer.apple.com/samplecode/AppleJavaExtensions/AppleJavaExtensions.zip"
LICENSE="Apple"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=""
RDEPEND="virtual/jre"

S=${WORKDIR}/AppleJavaExtensions

src_compile() { :; }

src_install() {
	dodoc README.txt
	java-pkg_dojar AppleJavaExtensions.jar
}

