# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/squareness-jlf/squareness-jlf-2.3.0.ebuild,v 1.1 2008/07/12 09:41:28 serkan Exp $

JAVA_PKG_IUSE="doc source"
inherit java-pkg-2 java-ant-2

DESCRIPTION="Squareness Java Look and Feel"
HOMEPAGE="http://squareness.beeger.net/"
SRC_URI="mirror://sourceforge/squareness/${PN/-/_}_src-${PV}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}"

RDEPEND=">=virtual/jre-1.4
	dev-java/laf-plugin"

DEPEND=">=virtual/jdk-1.4
	dev-java/laf-plugin"

EANT_GENTOO_CLASSPATH="laf-plugin"

src_unpack() {
	unpack ${A}
	cp "${FILESDIR}"/build.xml . -v || die
}

src_install() {
	java-pkg_dojar ${PN}.jar
	use doc && java-pkg_dojavadoc docs
	use source && java-pkg_dosrc net
}
