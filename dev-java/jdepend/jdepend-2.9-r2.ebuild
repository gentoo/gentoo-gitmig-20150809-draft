# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdepend/jdepend-2.9-r2.ebuild,v 1.5 2006/10/17 02:35:52 nichoj Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="JDepend traverses Java class file directories and generates design quality metrics for each Java package."
HOMEPAGE="http://www.clarkware.com/software/JDepend.html"
SRC_URI="http://www.clarkware.com/software/${P}.zip"

LICENSE="jdepend"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.3
	>=app-arch/unzip-5.50-r1
	>=dev-java/ant-core-1.4
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.3"

src_compile() {
	eant jar
}

src_install() {
	java-pkg_newjar dist/jdepend-2.9.jar
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
