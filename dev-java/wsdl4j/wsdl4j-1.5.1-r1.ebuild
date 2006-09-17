# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/wsdl4j/wsdl4j-1.5.1-r1.ebuild,v 1.1 2006/09/17 20:13:13 nichoj Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Web Services Description Language for Java Toolkit (WSDL4J)"
HOMEPAGE="http://wsdl4j.sourceforge.net"
SRC_URI="mirror://gentoo/${P}-gentoo.tar.bz2"

LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.4
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

src_compile() {
	eant compile $(use_doc javadocs)
}

src_install() {
	java-pkg_dojar build/lib/*.jar

	dohtml doc/*.html
	dodoc doc/spec/*

	use doc && java-pkg_dohtml -r build/javadocs/
	use source && java-pkg_dosrc src/*
}
