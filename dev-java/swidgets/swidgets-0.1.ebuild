# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/swidgets/swidgets-0.1.ebuild,v 1.9 2007/01/28 19:36:52 wltjr Exp $

inherit java-pkg

DESCRIPTION="Various reusable SWING components"
HOMEPAGE="http://swidgets.tigris.org"
SRC_URI="http://swidgets.tigris.org/files/documents/1472/18566/swidgets-${PV}-src.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="jikes source"

RDEPEND=">=virtual/jre-1.4
	 dev-java/toolbar"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	app-arch/unzip
	source? ( app-arch/zip )"

src_unpack() {
	unpack ${A}

	# Remove the CVS directories
	find . -name 'CVS' | xargs rmdir

	# Remove the unneeded directory
	mv src/org ${S}
	rm -rf src

	# Copy the build.xml
	cp ${FILESDIR}/build.xml ${S} || die "Unable to copy the build file!"

	# Create the build.properties file
	cat > ${S}/build.properties <<- EOF
		src=.
		dest=dest
		build=build
		version=${PV}
		classpath=$(java-pkg_getjars toolbar)
	EOF
}

src_compile() {
	local antflags=""
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "Compile failed!"
}

src_install() {
	java-pkg_newjar dest/swidgets-${PV}.jar ${PN}.jar

	use source && java-pkg_dosrc tigris
}
