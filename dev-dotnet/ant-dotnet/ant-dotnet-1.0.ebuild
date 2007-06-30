# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/ant-dotnet/ant-dotnet-1.0.ebuild,v 1.1 2007/06/30 22:30:12 jurek Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Library that allows using ant to build and test .NET parts of a project"
HOMEPAGE="http://ant.apache.org/antlibs/"
SRC_URI="mirror://apache/ant/antlibs/dotnet/source/apache-${P}-src.tar.bz2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=virtual/jre-1.2
		>=dev-lang/mono-1.1"

DEPEND="${RDEPEND}
		>=virtual/jdk-1.2
		>=dev-java/ant-core-1.7.0"

S="${WORKDIR}/apache-${P}"

EANT_BUILD_TARGET="antlib"
EANT_DOC_TARGET=""

src_install() {
	java-pkg_newjar build/lib/${P}.jar ${PN}.jar
	java-pkg_register-ant-task ${PN}

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r docs/*
	fi

	dodoc NOTICE TODO WHATSNEW CONTRIBUTORS README
	dohtml README.html
}
