# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/ant-dotnet/ant-dotnet-1.0.ebuild,v 1.3 2008/07/01 19:45:06 betelgeuse Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Library that allows using ant to build and test .NET parts of a project"
HOMEPAGE="http://ant.apache.org/antlibs/"
SRC_URI="mirror://apache/ant/antlibs/dotnet/source/apache-${P}-src.tar.bz2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=virtual/jre-1.4
		>=dev-java/ant-core-1.7.0
		>=dev-lang/mono-1.1"

DEPEND="${RDEPEND}
		>=virtual/jdk-1.4"

S="${WORKDIR}/apache-${P}"

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_BUILD_TARGET="antlib"
EANT_DOC_TARGET=""
EANT_GENTOO_CLASSPATH="ant-core"

src_install() {
	java-pkg_newjar build/lib/${P}.jar
	java-pkg_register-ant-task

	if use doc; then
		insinto /usr/share/doc/${PF} || die "insinto failed"
		doins -r docs/* || die "doins failed"
	fi

	dodoc NOTICE TODO WHATSNEW CONTRIBUTORS README || die "dodoc failed"
	dohtml README.html || die "dohtml failed"
}
