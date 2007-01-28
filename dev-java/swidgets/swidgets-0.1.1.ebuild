# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/swidgets/swidgets-0.1.1.ebuild,v 1.3 2007/01/28 20:48:13 wltjr Exp $

inherit java-pkg

DESCRIPTION="Various reusable SWING components"
HOMEPAGE="http://swidgets.tigris.org"
SRC_URI="http://swidgets.tigris.org/files/documents/1472/18566/swidgets-${PV}-src.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="jikes source"

RDEPEND="virtual/jre
		 dev-java/toolbar"

DEPEND="${RDEPEND}
		virtual/jdk
		dev-java/ant-core
		app-arch/unzip
		source? ( app-arch/zip )"

src_unpack() {
	unpack ${A}

	# Remove the CVS directories
	find . -name 'CVS' | xargs rmdir

	# Create the directory structor
	mkdir ${S}

	# Move the broken out source file
	mv src ${S}
	mv LabelledLayout.java ${S}/src/org/tigris/swidgets/

	# Copy the build.xml
	cp ${FILESDIR}/build.xml ${S} || die "Unable to copy the build file!"

	cat > ${S}/build.properties <<- EOF
		src=src
		dest=dest
		build=build
		version=${PV}
		classpath=$(java-config -p toolbar)
	EOF
}

src_compile() {
	local antflags=""
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"

	ant ${antflags} || die "Compile failed!"
}

src_install() {
	java-pkg_newjar dest/swidgets-${PV}.jar ${PN}.jar
	use source && java-pkg_dosrc ${S}/src/org/
}
