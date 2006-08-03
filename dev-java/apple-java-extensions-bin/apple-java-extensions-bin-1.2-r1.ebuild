# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/apple-java-extensions-bin/apple-java-extensions-bin-1.2-r1.ebuild,v 1.1 2006/08/03 10:30:08 nelchael Exp $

inherit java-pkg-2

DESCRIPTION="This is a pluggable jar of stub classes representing the new Apple eAWT and eIO APIs for Java 1.4 on Mac OS X. The purpose of these stubs is to allow for compilation of eAWT- or eIO-referencing code on platforms other than Mac OS X"
HOMEPAGE="http://developer.apple.com/samplecode/AppleJavaExtensions/AppleJavaExtensions.html"
SRC_URI="http://developer.apple.com/samplecode/AppleJavaExtensions/AppleJavaExtensions.zip"
LICENSE="Apple"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jre-1.3"

S=${WORKDIR}/AppleJavaExtensions

src_install() {
	dodoc README.txt
	java-pkg_dojar AppleJavaExtensions.jar
}
