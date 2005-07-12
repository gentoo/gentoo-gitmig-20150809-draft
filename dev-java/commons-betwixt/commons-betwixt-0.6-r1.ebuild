# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-betwixt/commons-betwixt-0.6-r1.ebuild,v 1.3 2005/07/12 09:52:21 axxo Exp $

inherit java-pkg eutils

DESCRIPTION="Introspective Bean to XML mapper"
HOMEPAGE="http://jakarta.apache.org/commons/betwixt/"
SRC_URI="mirror://apache/jakarta/commons/betwixt/source/${P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86 ~ppc"
IUSE="doc jikes source"

RDEPEND=">=virtual/jre-1.3
	>=dev-java/commons-logging-1.0.2
	=dev-java/commons-beanutils-1.7*
	>=dev-java/commons-digester-1.6"
DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	dev-java/ant-core
	jikes? ( >=dev-java/jikes-1.21 )
	source? ( app-arch/zip )"

S="${WORKDIR}/${P}-src/"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-noget.patch

	mkdir -p ${S}/target/lib && cd ${S}/target/lib
	java-pkg_jar-from commons-beanutils-1.7
	java-pkg_jar-from commons-digester
	java-pkg_jar-from commons-logging
}

src_compile() {
	local antflags="init jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_newjar target/${PN}*.jar ${PN}.jar

	dodoc RELEASE-NOTES.txt
	if use doc; then
		java-pkg_dohtml PROPOSAL.html STATUS.html userguide.html
		java-pkg_dohtml -r dist/docs/
	fi
	use source && java-pkg_dosrc src/java/*
}
