# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-discovery/commons-discovery-0.2-r2.ebuild,v 1.1 2005/01/05 16:46:35 karltk Exp $

inherit java-pkg eutils
DESCRIPTION=" The Discovery Component is about discovering, or finding, implementations for pluggable interfaces. It provides facilities intantiating classes in general, and for lifecycle management of singleton (factory) classes."
HOMEPAGE="http://jakarta.apache.org/commons/discovery"
SRC_URI="mirror://apache/jakarta/commons/discovery/source/${PN}-${PV}-src.tar.gz"
DEPEND=">=dev-java/ant-core-1.5.4-r2
	jikes? ( >=dev-java/jikes-1.21 )
	junit? ( >=dev-java/junit-3.8 >=virtual/jdk-1.4 )
	dev-java/commons-logging
	!junit? ( >=virtual/jdk-1.3 ) "
RDEPEND=">=virtual/jdk-1.3"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="junit jikes doc"

S="${WORKDIR}/${P}-src/discovery"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-${PV}-gentoo.diff
	mkdir -p target/lib
	cd target/lib
	java-pkg_jar-from junit junit.jar || die "Could not link to junit"
	java-pkg_jar-from commons-logging || die "Could not link to commons-logging"
}

src_compile() {
	local antflags="dist"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	use junit && antflags="${antflags} test.discovery"
	ant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	dodoc RELEASE-NOTES.txt
	dohtml PROPOSAL.html STATUS.html usersguide.html
}
