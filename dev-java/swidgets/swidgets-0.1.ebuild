# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/swidgets/swidgets-0.1.ebuild,v 1.3 2005/03/29 06:35:22 compnerd Exp $

inherit java-pkg

DESCRIPTION="Various reusable SWING components"
HOMEPAGE="http://swidgets.tigris.org"
SRC_URI="http://swidgets.tigris.org/files/documents/1472/18566/swidgets-${PV}-src.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86"
IUSE="jikes"

DEPEND="${RDEPEND}
		virtual/jdk
		app-arch/unzip"
RDEPEND="virtual/jre
		 dev-java/toolbar"

src_unpack() {
	unpack ${A} || die "Unpack failed!"

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
		classpath=$(java-config -p toolbar)
	EOF
}

src_compile() {
	local antflags=""
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"

	ant ${antflags} -f build.xml || die "Compile failed!"
}

src_install() {
	java-pkg_dojar dest/swidgets-${PV}.jar
}
