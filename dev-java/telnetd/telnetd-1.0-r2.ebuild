# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/telnetd/telnetd-1.0-r2.ebuild,v 1.5 2007/08/15 05:57:35 wltjr Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A telnet daemon for use in java applications"
HOMEPAGE="http://telnetd.sourceforge.net/"
SRC_URI="mirror://sourceforge/telnetd/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

COMMON_DEP=">=dev-java/xerces-2.7"

RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND="|| (
	=virtual/jdk-1.5*
	=virtual/jdk-1.4* )
	${COMMON_DEP}
	app-arch/unzip"

src_unpack() {

	unpack ${A}

	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from xerces-2

}

EANT_DOC_TARGET="javadocs"

src_install() {

	java-pkg_dojar build/telnetd.jar

	use doc && java-pkg_dojavadoc build/site/api
	use source && java-pkg_dosrc src/net

}
