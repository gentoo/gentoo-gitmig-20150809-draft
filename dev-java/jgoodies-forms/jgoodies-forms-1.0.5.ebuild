# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jgoodies-forms/jgoodies-forms-1.0.5.ebuild,v 1.3 2005/03/30 23:49:14 compnerd Exp $

inherit java-pkg

MY_V=${PV//./_}
DESCRIPTION="JGoodies Forms Library"
HOMEPAGE="http://www.jgoodies.com/"
SRC_URI="http://www.jgoodies.com/download/libraries/forms-${MY_V}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc jikes source"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.4
	app-arch/unzip
	jikes? ( >=dev-java/jikes-1.21 )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/forms-${PV}"

src_unpack() {
	unpack ${A} || die "Unpack failed"
	cd ${S}

	# Remove the packaged jars
	rm *.jar

	# Extract the sources
	unzip forms-${PV}-src.zip &> /dev/null || die "Unpack Failed"

	# No support for junit tests yet
	rm -rf ${S}/src/test

	# Copy the Gentoo'ized build.xml
	cp ${FILESDIR}/build.xml ${S}/build.xml
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"

	ant ${antflags} || die "Compile failed"
}

src_install() {
	java-pkg_dojar forms-${PV}.jar

	dodoc LICENSE.txt RELEASE-NOTES.txt

	use doc && java-pkg_dohtml -r build/doc
	use source && java-pkg_dosrc ${S}/com
}
