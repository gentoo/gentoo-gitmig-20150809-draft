# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/classworlds/classworlds-1.0-r2.ebuild,v 1.11 2005/07/16 12:29:59 axxo Exp $

inherit java-pkg

DESCRIPTION="Advanced classloader framework"
HOMEPAGE="http://dist.codehaus.org/classworlds/distributions/classworlds-1.0-src.tar.gz"
SRC_URI="http://dist.codehaus.org/classworlds/distributions/${P}-src.tar.gz"
LICENSE="codehaus-classworlds"
SLOT="1"
KEYWORDS="x86 ~ppc amd64"
IUSE="doc jikes"
RDEPEND=">=virtual/jre-1.4
	=dev-java/xerces-2.6*"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	jikes? ( >=dev-java/jikes-1.21 )
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
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "Failed to compile jars"
}

src_install() {
	java-pkg_newjar target/${P}.jar ${PN}.jar
	use doc && java-pkg_dohtml -r dist/docs/api
}
