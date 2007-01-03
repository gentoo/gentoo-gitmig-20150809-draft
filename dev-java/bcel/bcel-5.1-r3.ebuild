# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bcel/bcel-5.1-r3.ebuild,v 1.9 2007/01/03 20:44:18 beandog Exp $

inherit java-pkg-2 eutils java-ant-2

DESCRIPTION="The Byte Code Engineering Library: analyze, create, manipulate Java class files"
HOMEPAGE="http://jakarta.apache.org/bcel/"
SRC_URI="mirror://apache/jakarta/${PN}/source/${P}-src.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"
IUSE="doc source"
COMMON_DEP="=dev-java/jakarta-regexp-1.3*"
RDEPEND=">=virtual/jre-1.3
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.3
	app-arch/unzip
	dev-java/ant-core
	source? ( app-arch/zip )
	${COMMON_DEP}"

src_unpack() {
	unpack ${A}
	unzip -q "${P}-src.zip" || die "failed to unpack"

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo-buildxml.diff
	epatch ${FILESDIR}/${P}-gentoo-src.diff

	echo "regexp.jar=$(java-pkg_getjars jakarta-regexp-1.3)" > build.properties
}

src_compile() {
	eant jar $(use_doc apidocs)
}

src_install() {
	java-pkg_dojar bin/bcel.jar

	if use doc; then
		dodoc LICENSE.txt
		java-pkg_dohtml -r docs/
	fi
	use source && java-pkg_dosrc src/java/*
}
