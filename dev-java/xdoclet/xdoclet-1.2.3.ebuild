# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xdoclet/xdoclet-1.2.3.ebuild,v 1.1 2006/07/23 09:11:46 nelchael Exp $

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="XDoclet is an extended Javadoc Doclet engine."
HOMEPAGE="http://xdoclet.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.tgz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="source"

RDEPEND=">=virtual/jre-1.3
	=dev-java/bsf-2.3*
	dev-java/commons-collections
	dev-java/commons-logging
	dev-java/log4j
	dev-java/mockobjects
	dev-java/velocity
	dev-java/xjavadoc"
DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	dev-java/ant
	source? ( app-arch/zip )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-interface.patch
	epatch ${FILESDIR}/${P}-buildfile.patch

	cd ${S}/lib && rm -f *.jar
	java-pkg_jar-from xjavadoc
	java-pkg_jar-from bsf-2.3
	java-pkg_jar-from velocity
	java-pkg_jar-from log4j
	java-pkg_jar-from mockobjects
	java-pkg_jar-from commons-logging
	java-pkg_jar-from commons-collections
	java-pkg_jar-from velocity
}

src_compile() {
	local antflags="core modules maven"
	eant ${antflags} || die "Failed to compile XDoclet core."
}

src_install() {
	for jar in target/lib/*.jar; do
		java-pkg_newjar ${jar} $(basename ${jar/-${PV}/})
	done

	dodoc README.txt
	use source && java-pkg_dosrc core/src/xdoclet modules/*
}

