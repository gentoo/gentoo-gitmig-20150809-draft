# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/toolbar/toolbar-0.4.ebuild,v 1.2 2005/03/29 05:43:52 compnerd Exp $

inherit java-pkg

DESCRIPTION="An improved version of JToolBar"
HOMEPAGE="http://toolbar.tigris.org"
SRC_URI="http://toolbar.tigris.org/files/documents/869/10303/ToolBar-0.4-src.zip"

SLOT="0"
KEYWORDS="~x86"
LICENSE="Apache-2.0"

IUSE="jikes"
DEPEND=">=virtual/jdk-1.4
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	unpack ${A} || die "Unpack failed"

	# Remove the CVS directories
	find . -name 'CVS' | xargs rmdir

	# Remove the src and test directores
	mv src/org ${S}
	rm -rf src test

	# Copy over the build.xml
	cp ${FILESDIR}/build.xml ${S} || die "Unable to copy the build file!"
}

src_compile() {
	local antflags="-Dversion=${PV}"
	$(use jikes) && antflags="${antflags} -Dbuild.compiler=jikes"

	ant ${antflags} -f build.xml || die "Compile failed!"
}

src_install() {
	java-pkg_dojar dest/toolbar-${PV}.jar
}
