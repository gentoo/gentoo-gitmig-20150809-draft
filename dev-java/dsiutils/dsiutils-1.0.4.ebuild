# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/dsiutils/dsiutils-1.0.4.ebuild,v 1.2 2012/04/13 18:05:15 ulm Exp $

EAPI="1"
JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A Mish Mash of classes that were initially distributed with mg4j (amount others)."
HOMEPAGE="http://dsiutils.dsi.unimi.it/"
SRC_URI="http://dsiutils.dsi.unimi.it/${P}-src.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

IUSE=""

COMMON_DEP="dev-java/commons-io:1
			=dev-java/jsap-2*
			dev-java/log4j
			dev-java/commons-collections
			dev-java/colt
			=dev-java/fastutil-5.1*
			dev-java/commons-configuration
			dev-java/commons-lang:2.1
			=dev-java/junit-3*"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	test? ( dev-java/emma )
	${COMMON_DEP}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	java-ant_rewrite-classpath
}

EANT_GENTOO_CLASSPATH="commons-io:1,jsap,log4j,commons-collections,colt,fastutil:5.0,commons-configuration,commons-lang:2.1,junit"

src_install() {
	java-pkg_newjar "${P}.jar"
	use doc && java-pkg_dojavadoc docs
	use source && java-pkg_dosrc src
}

#emma configuration files are currently not distributed with
#source.  therefore tests fail before even run.
RESTRICT="test"

src_test() {
	eant -Djar.base=/usr/share/emma/lib junit
}
