# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bsf/bsf-2.4.0.ebuild,v 1.4 2007/07/11 19:58:37 mr_bones_ Exp $

JAVA_PKG_IUSE="doc examples source"
inherit java-pkg-2 eutils java-ant-2

DESCRIPTION="Bean Script Framework"
HOMEPAGE="http://jakarta.apache.org/bsf/"
SRC_URI="mirror://apache/jakarta/bsf/source/${PN}-src-${PV}.tar.gz"
LICENSE="Apache-2.0"
SLOT="2.3"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="python rhino tcl"

COMMON_DEP="dev-java/commons-logging
	dev-java/xalan
	python? ( >=dev-java/jython-2.1-r5 )
	rhino? ( =dev-java/rhino-1.6* )
	tcl? ( dev-java/jacl )"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	${COMMON_DEP}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	rm -v lib/*.jar || die
	rm samples/*/*.class || die

	java-ant_ignore-system-classes
	java-ant_rewrite-classpath

	# somebody forgot to add them to source tarball... fetched from svn
	cp "${FILESDIR}/${P}-build-properties.xml" build-properties.xml || die
}

src_compile() {
	local pkgs="commons-logging,xalan"
	local antflags="-Dxalan.present=true"
	if use python; then
		antflags="${antflags} -Djython.present=true"
		pkgs="${pkgs},jython"
	fi
	if use rhino; then
		antflags="${antflags} -Drhino.present=true"
		pkgs="${pkgs},rhino-1.6"
	fi
	if use tcl; then
		antflags="${antflags} -Djacl.present=true"
		pkgs="${pkgs},jacl"
	fi

	local cp="$(java-pkg_getjars ${pkgs})"
	eant -Dgentoo.classpath="${cp}" ${antflags} jar
	# stupid clean
	mv build/lib/${PN}.jar ${S} || die
	use doc && eant -Dgentoo.classpath="${cp}" ${antflags} javadocs
}

src_install() {
	java-pkg_dojar ${PN}.jar

	java-pkg_dolauncher ${PN} --main org.apache.bsf.Main

	dodoc CHANGES.txt NOTICE.txt README.txt RELEASE-NOTE.txt TODO.txt || die

	use doc && java-pkg_dojavadoc build/javadocs
	use examples && java-pkg_doexamples samples
	use source && java-pkg_dosrc src/org
}
