# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/axion/axion-1.0_rc2.ebuild,v 1.1 2004/03/30 23:59:47 karltk Exp $

inherit java-pkg

DESCRIPTION="Java RDMS with SQL and JDBC"
HOMEPAGE="http://axion.tigris.org/"
SRC_URI="http://axion.tigris.org/releases/1.0M2/axion-1.0-M2-src.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"
RDEPEND=">=dev-java/commons-collections-2.1
	=dev-java/commons-primitives-1.0*
	=dev-java/commons-codec-1.2*
	=dev-java/log4j-1.2*
	=dev-java/regexp-1.3*
	"
DEPEND="${RDEPEND}
	jikes? >=dev-java/jikes-1.19
	junit? >=dev-java/junit-3.8.1
	>=dev-java/ant-1.5.4"

S=${WORKDIR}/${PN}-1.0-M2

src_unpack() {
	unpack ${A}
	cd ${S}
	# It's pure luck that this works. Only the first element of
	# each classpath will be picked. We need to symlink all
	# jarfiles into lib/ at some point.
	( echo junit.jar=$(java-config -p junit)
	  echo collections.jar=$(java-config -p commons-collections)
	  echo primitives.jar=$(java-config -p commons-primitives)
	  echo logging.jar=$(java-config -p commons-logging)
	  echo codec.jar=$(java-config -p commons-codec)
	  echo logging-impl.jar=$(java-config -p log4j)
	  echo regexp.jar=$(java-config -p regexp)
	  echo javacc.home=/usr/share/javacc/lib
	) > build.properties

	mkdir lib test
	# Given the state of brokenness in this build system, we will
	# need to do this for all the jars it depends on.
	(
		cd lib
		for x in $(java-config -p commons-primitives | tr -d :) ; do
			ln -s ${x} .
		done
	)
}

src_compile() {
	local antflags="compile jar"
	use jikes && antflags="-Dbuild.compiler=jikes ${antflags}"
	use doc && antflags="${antflags} javadoc"
	use junit && antflags="${antflags} test"
	ant ${antflags} || die "Compilation failed"
}

src_install() {
	java-pkg_dojar bin/axion-1.0-M2.jar

	use doc && dohtml -r bin/docs/api
}
