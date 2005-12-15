# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-betwixt/commons-betwixt-0.7.ebuild,v 1.1 2005/12/15 05:20:14 nichoj Exp $

inherit java-pkg eutils

DESCRIPTION="Introspective Bean to XML mapper"
HOMEPAGE="http://jakarta.apache.org/commons/betwixt/"
SRC_URI="mirror://apache/jakarta/commons/betwixt/source/${P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0.7"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE="doc jikes test source"

RDEPEND=">=virtual/jre-1.3
	>=dev-java/commons-logging-1.0.2
	=dev-java/commons-beanutils-1.7*
	>=dev-java/commons-digester-1.6"
DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	dev-java/ant-core
	jikes? ( >=dev-java/jikes-1.21 )
	test? ( dev-java/ant-tasks >=dev-java/xerces-2.6 )
	source? ( app-arch/zip )"

S="${WORKDIR}/${P}-src/"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-notests.patch

	cd ${S}
	mkdir -p ${S}/target/lib && cd ${S}/target/lib
	java-pkg_jar-from commons-beanutils-1.7
	java-pkg_jar-from commons-digester
	java-pkg_jar-from commons-logging
	use test && java-pkg_jar-from xerces-2
}

src_compile() {
	local antflags="init jar -Dnoget=true -Dnotest=true"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_newjar target/${PN}*.jar ${PN}.jar

	dodoc RELEASE-NOTES.txt README.txt
	if use doc; then
		java-pkg_dohtml PROPOSAL.html STATUS.html userguide.html
		java-pkg_dohtml -r dist/docs/
	fi
	use source && java-pkg_dosrc src/java/*
}

src_test() {
	if ! use test; then
		ewarn "You must USE=test in order to get the dependencies needed"
		ewarn "to run tests"
		ewarn "Skipping the tests"
	else
		ant test -Dnoget=true || die "tests failed"
	fi
}
