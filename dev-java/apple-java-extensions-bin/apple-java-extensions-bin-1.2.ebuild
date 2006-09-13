# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/apple-java-extensions-bin/apple-java-extensions-bin-1.2.ebuild,v 1.8 2006/09/13 22:41:15 nichoj Exp $

inherit java-pkg

DESCRIPTION="A pluggable jar of stub classes representing the new Apple eAWT and eIO APIs for Java 1.4 on Mac OS X."
HOMEPAGE="http://developer.apple.com/samplecode/AppleJavaExtensions/AppleJavaExtensions.html"
SRC_URI="http://developer.apple.com/samplecode/AppleJavaExtensions/AppleJavaExtensions.zip"
LICENSE="Apple"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""
DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jre-1.3"

S=${WORKDIR}/AppleJavaExtensions

src_install() {
	dodoc README.txt
	java-pkg_dojar AppleJavaExtensions.jar
}

