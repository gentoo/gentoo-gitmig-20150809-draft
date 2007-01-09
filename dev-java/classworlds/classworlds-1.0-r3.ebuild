# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/classworlds/classworlds-1.0-r3.ebuild,v 1.1 2007/01/09 17:17:04 nelchael Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Advanced classloader framework"
HOMEPAGE="http://dist.codehaus.org/classworlds/distributions/classworlds-1.0-src.tar.gz"
SRC_URI="http://dist.codehaus.org/classworlds/distributions/${P}-src.tar.gz"
LICENSE="codehaus-classworlds"
SLOT="1"
KEYWORDS="amd64 ~ppc x86"
IUSE="doc"

RDEPEND=">=virtual/jre-1.4
	>=dev-java/xerces-2.7"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	>=dev-java/ant-core-1.6"

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/build-${PV}.xml ${S}/build.xml
	mkdir -p ${S}/target/lib

	cd ${S}/target/lib

	# karltk: remove the fake versioning here.
	java-pkg_jar-from xerces-2
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	eant ${antflags}
}

src_install() {
	java-pkg_newjar target/${P}.jar ${PN}.jar
	use doc && java-pkg_dohtml -r dist/docs/api
}
