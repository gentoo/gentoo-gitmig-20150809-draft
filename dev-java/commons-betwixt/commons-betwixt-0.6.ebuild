# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-betwixt/commons-betwixt-0.6.ebuild,v 1.1 2005/03/28 22:25:17 luckyduck Exp $

inherit java-pkg eutils

DESCRIPTION="Introspective Bean to XML mapper"
HOMEPAGE="http://jakarta.apache.org/commons/betwixt/"
SRC_URI="mirror://apache/jakarta/commons/betwixt/source/${PN}-${PV}-src.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="doc jikes source"

DEPEND=">=dev-java/commons-logging-1.0.2
	>=dev-java/commons-beanutils-1.7.0
	>=dev-java/commons-digester-1.6
	>=dev-java/ant-core-1.4
	jikes? ( >=dev-java/jikes-1.21 )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jdk-1.3"

S="${WORKDIR}/${P}-src/"

src_unpack() {
	unpack ${A} && cd $S
	echo "commons-logging.jar=`java-config -p commons-logging`" \
		> build.properties
	echo "commons-beanutils.jar=`java-config -p commons-beanutils`" \
		>> build.properties
	echo "commons-digester.jar=`java-config -p commons-digester`" \
		>> build.properties

	epatch ${FILESDIR}/${P}-noget.patch
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_dojar target/${PN}.jar

	if use doc; then
		dodoc RELEASE-NOTES.txt
		java-pkg_dohtml PROPOSAL.html STATUS.html userguide.html
		java-pkg_dohtml -r dist/docs/
	fi
	use source && java-pkg_dosrc src/java/*
}
