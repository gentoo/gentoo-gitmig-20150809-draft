# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/swidgets/swidgets-0.1.ebuild,v 1.1 2005/03/29 06:10:39 compnerd Exp $

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
}

src_compile() {
	cd ${S}

	touch build.properties
	echo "src=." >> build.properties
	echo "dest=dest" >> build.properties
	echo "build=build" >> build.properties
	echo "version=${PV}" >> build.properties
	echo "classpath=$(java-config -p toolbar)" >> build.properties

	local antflags=""
	$(use jikes) && antflags="${antflags} -Dbuild.compiler=jikes"

	ant ${antflags} -f build.xml || die "Compile failed!"
}

src_install() {
	java-pkg_dojar dest/swidgets-${PV}.jar
}
