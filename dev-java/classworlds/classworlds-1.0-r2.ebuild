# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/classworlds/classworlds-1.0-r2.ebuild,v 1.9 2005/01/05 09:14:38 luckyduck Exp $

inherit java-pkg

DESCRIPTION="Advanced classloader framework"
HOMEPAGE="http://dist.codehaus.org/classworlds/distributions/classworlds-1.0-src.tar.gz"
SRC_URI="http://dist.codehaus.org/classworlds/distributions/${P}-src.tar.gz"
LICENSE="codehaus-classworlds"
SLOT="1"
KEYWORDS="x86 ~ppc ~amd64"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.4
	jikes? ( >=dev-java/jikes-1.21 )
	>=dev-java/ant-core-1.6"
RDEPEND=">=virtual/jre-1.4
	=dev-java/xerces-2.6*"

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/build-${PV}.xml ${S}/build.xml
	mkdir -p ${S}/target/lib

	cd ${S}/target/lib

	# karltk: remove the fake versioning here.
	java-pkg_jar-from xerces-2 || die "Missing xerces"
}

src_compile() {
	local myconf="jar"
	if use jikes; then
		myconf="${myconf} -Dbuild.compiler=jikes"
	fi
	if use doc; then
		myconf="${myconf} javadoc"
	fi
	ant ${myconf} || die "Failed to compile jars"
}

src_install() {
	dodoc LICENSE.txt
	java-pkg_dojar target/classworlds-1.0.jar
	use doc && java-pkg_dohtml -r dist/docs/api
}
