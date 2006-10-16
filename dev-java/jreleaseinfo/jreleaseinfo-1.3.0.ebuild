# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jreleaseinfo/jreleaseinfo-1.3.0.ebuild,v 1.1 2006/10/16 21:36:16 caster Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Ant Task for build-time creation of Java source file with program version, build number or any other info"
HOMEPAGE="http://${PN}.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.zip"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86"
IUSE="source"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	dev-java/ant-core
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	unpack ${A}
	cd "${S}"

	java-ant_rewrite-classpath build.xml
}

src_compile() {
	local gcp="$(java-pkg_getjar --build-only ant-core ant.jar)"
	eant -Dgentoo.classpath="${gcp}" jar
}

src_install() {
	java-pkg_newjar "target/${P}.jar"
	dodoc LICENSE.txt
	use source && java-pkg_dosrc src/java/ch
}
