# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/toolbar/toolbar-0.4.ebuild,v 1.5 2005/03/29 08:51:08 luckyduck Exp $

inherit java-pkg

DESCRIPTION="An improved version of JToolBar"
HOMEPAGE="http://toolbar.tigris.org"
SRC_URI="http://toolbar.tigris.org/files/documents/869/10303/ToolBar-${PV}-src.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="jikes source"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	app-arch/unzip
	source? ( app-arch/zip )"
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
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "Compile failed!"
}

src_install() {
	java-pkg_dojar dest/toolbar-${PV}.jar

	use source && java-pkg_dosrc src/*
}
