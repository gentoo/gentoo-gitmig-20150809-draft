# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/trang/trang-20030619-r1.ebuild,v 1.1 2004/11/14 16:13:18 axxo Exp $

inherit java-pkg

DESCRIPTION="Trang: Multi-format schema converter based on RELAX NG"
HOMEPAGE="http://thaiopensource.com/relaxng/trang.html"
SRC_URI="http://www.thaiopensource.com/download/trang-${PV}.zip"
LICENSE="BSD Apache-1.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="jikes"
DEPEND="dev-java/saxon-bin
	=dev-java/xerces-1.3.1
	>=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	unpack ${A}
	cd ${S}

	mkdir -p src/lib
	unzip -d src src.zip
	cp ${FILESDIR}/build.xml src

	cd src/lib
	java-pkg_jar-from xerces-1.3 xerces.jar
}

src_compile() {
	cd ${S}/src
	antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "failed to build"
}

src_install() {
	cd ${S}
	java-pkg_dojar jar/trang.jar
	cat >trang <<'EOF'
#!/bin/sh
exec `java-config --java` -jar `java-config -p trang` "$@"
EOF
	dobin trang
	dohtml *.html
	dodoc copying.txt
}
