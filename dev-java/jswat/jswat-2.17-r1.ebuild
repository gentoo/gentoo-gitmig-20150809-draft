# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jswat/jswat-2.17-r1.ebuild,v 1.1 2003/05/24 10:24:45 absinthe Exp $

inherit java-pkg

S="${WORKDIR}/${PN}-${PV}"
DESCRIPTION="Extensible graphical Java debugger"
HOMEPAGE="http://www.bluemarsh.com/java/jswat"
SRC_URI="mirror://sourceforge/jswat/${PN}-src-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="2"
KEYWORDS="x86 sparc ppc"
DEPEND=">=dev-java/ant-1.4.1"
RDEPEND=">=virtual/jdk-1.4"
IUSE="doc jikes junit"

src_compile() {
	antopts="-Dversion=${PV}"
	use jikes && antopts="${antopts} -Dbuild.compiler=jikes"
	ant ${antopts} dist || die "Compile failed"
	
	# Make sure junit tasks get built if we have junit
	if [ -f "/usr/share/junit/lib/junit.jar" ] ; then
		export CLASSPATH="/usr/share/junit/lib/junit.jar"
		export DEP_APPEND="junit"
		if [ `use junit` ] 
			then
				einfo "Running JUnit tests, this may take awhile ..."
				ant ${antopts} test || die "Junit test failed"
		fi
	fi
	
}

src_install () {
	# install jswat classes
	java-pkg_dojar \
		build/dist/${P}/*.jar \
		classes/ext/parser.jar \
		classes/ext/jclasslib.jar
	
	# prepare and install jswat script
	dobin ${FILESDIR}/jswat2
	
	# install documents
	dodoc AUTHORS.txt BUGS.txt HISTORY.txt LICENSE.txt OLD_HISTORY.txt TODO.txt
	dohtml README.html
	use doc && dohtml -r docs
}
