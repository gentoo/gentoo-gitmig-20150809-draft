# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jgoodies-animation/jgoodies-animation-1.1.3.ebuild,v 1.2 2005/03/31 00:17:00 compnerd Exp $

inherit java-pkg

MY_V=${PV//./_}
DESCRIPTION="JGoodies Animation Library"
HOMEPAGE="http://www.jgoodies.com/"
SRC_URI="http://www.jgoodies.com/download/libraries/animation-${MY_V}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc jikes"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.4
	app-arch/unzip
	jikes? ( >=dev-java/jikes-1.21 )"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/animation-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Remove the packaged jar
	rm *.jar

	# Extract the sources
	unzip animation-${PV}-src.zip &> /dev/null || die "Unpack Failed"

	# No JUNIT support yet :-(
	rm -rf ${S}/src/test

	# Copy the Gentoo'ized build.xml
	cp ${FILESDIR}/build.xml ${S}
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"

	ant ${antflags} || die "Compile failed"
}

src_install() {
	java-pkg_dojar animation-${PV}.jar

	dodoc LICENSE.txt RELEASE-NOTES.txt
	use doc && java-pkg_dohtml -r build/doc
}
