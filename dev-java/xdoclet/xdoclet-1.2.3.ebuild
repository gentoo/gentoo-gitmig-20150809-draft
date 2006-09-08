# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xdoclet/xdoclet-1.2.3.ebuild,v 1.2 2006/09/08 05:26:02 nichoj Exp $

inherit java-pkg-2 eutils

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
	dev-java/xjavadoc
	dev-java/junit"
DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	dev-java/ant
	source? ( app-arch/zip )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-interface.patch
	epatch ${FILESDIR}/${P}-buildfile.patch
	# Fix javac tasks to have source="1.3" target="1.3"
	# because using xml-rewrite.py from java-ant-2 breaks the build,
	# because it doesn't support entities
	# TODO file upstream. Perhaps cleanup patch to use ant properties.
	epatch ${FILESDIR}/${P}-fix_javac.patch

	cd ${S}/lib && rm -f *.jar
	java-pkg_jar-from xjavadoc
	java-pkg_jar-from bsf-2.3
	java-pkg_jar-from velocity
	java-pkg_jar-from log4j
	java-pkg_jar-from mockobjects
	java-pkg_jar-from commons-logging
	java-pkg_jar-from commons-collections
	java-pkg_jar-from velocity
	java-pkg_jar-from ant-core ant.jar
	java-pkg_jar-from junit
}

# TODO investigate why compiling needs junit, ie is build not sane enough to
# devide building of test classes separate from rest of classes?
src_compile() {
	local antflags="core modules maven"
	eant ${antflags}
}

src_install() {
	for jar in target/lib/*.jar; do
		java-pkg_newjar ${jar} $(basename ${jar/-${PV}/})
	done

	dodoc README.txt
	use source && java-pkg_dosrc core/src/xdoclet modules/*
}

