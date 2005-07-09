# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdepend/jdepend-2.6-r1.ebuild,v 1.6 2005/07/09 16:04:16 axxo Exp $

inherit java-pkg

DESCRIPTION="JDepend traverses Java class file directories and generates design quality metrics for each Java package."
HOMEPAGE="http://www.clarkware.com/software/JDepend.html"
SRC_URI="http://www.clarkware.com/software/${P}.zip"

LICENSE="jdepend"
SLOT="0"
KEYWORDS="x86 amd64 ppc sparc"
IUSE="doc jikes source"

DEPEND=">=virtual/jdk-1.3
		>=app-arch/unzip-5.50-r1
		>=dev-java/ant-core-1.4
		jikes? ( >=dev-java/jikes-1.17 )
		source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.3"

#TODO Do junit testing but resolve the circular dependency we have with ant.
src_compile() {
	local antflags="jar"

	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
#	use junit && antflags="${antflags} test"

	ant ${antflags} || die "Failed Compiling"

}

src_install() {
	java-pkg_dojar lib/jdepend.jar || die "Failed Installing"
	dodoc README

	dodir /usr/share/ant-core/lib
	dosym /usr/share/jdepend/lib/jdepend.jar /usr/share/ant-core/lib

	if use doc; then
		dohtml docs/JDepend.html
		cp -r docs/api ${D}/usr/share/doc/${PF}/html
		cp -r docs/images ${D}/usr/share/doc/${PF}/html
	fi

	use source && java-pkg_dosrc src/*
}
