# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/jing/jing-20030619.ebuild,v 1.4 2004/08/01 07:01:46 mr_bones_ Exp $

DESCRIPTION="Jing: A RELAX NG validator in Java"
HOMEPAGE="http://thaiopensource.com/relaxng/jing.html"
SRC_URI="http://www.thaiopensource.com/download/jing-${PV}.zip"
LICENSE="BSD Apache-1.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND=">=virtual/jdk-1.3
	dev-java/saxon-bin
	dev-java/xerces"
DEPEND=""


src_install() {
	dojar bin/jing.jar
	cat >jing <<'EOF'
#!/bin/sh
exec `java-config --java` -classpath `java-config -p xerces,saxon` -jar `java-config -p jing` "$@"
EOF
	dobin jing
	dohtml -r doc/* readme.html
}
