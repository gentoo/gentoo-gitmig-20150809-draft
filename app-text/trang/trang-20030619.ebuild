# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/trang/trang-20030619.ebuild,v 1.7 2004/11/03 11:52:54 axxo Exp $

inherit java-pkg

DESCRIPTION="Trang: Multi-format schema converter based on RELAX NG"
HOMEPAGE="http://thaiopensource.com/relaxng/trang.html"
SRC_URI="http://www.thaiopensource.com/download/trang-${PV}.zip"
LICENSE="BSD Apache-1.1"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RDEPEND=">=virtual/jdk-1.3
	dev-java/saxon-bin
	dev-java/xerces"
DEPEND="app-arch/unzip"


src_install() {
	java-pkg_dojar trang.jar
	cat >trang <<'EOF'
#!/bin/sh
exec `java-config --java` -jar `java-config -p trang` "$@"
EOF
	dobin trang
	dohtml *.html
	dodoc copying.txt
}
