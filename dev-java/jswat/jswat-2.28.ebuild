# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jswat/jswat-2.28.ebuild,v 1.2 2004/11/03 11:34:08 axxo Exp $

inherit java-pkg eutils

DESCRIPTION="Extensible graphical Java debugger"
HOMEPAGE="http://www.bluemarsh.com/java/jswat"
SRC_URI="mirror://sourceforge/jswat/${PN}-src-${PV}.zip"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86 -ppc"
IUSE="doc jikes" #junit"

DEPEND=">=dev-java/ant-1.6
		app-arch/unzip
		dev-java/sablecc-anttask
		dev-java/sablecc"
	#junit? ( dev-java/junit )"
RDEPEND=">=virtual/jdk-1.4
		dev-java/jclasslib"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/build.xml.patch
	cd ${S}/classes/ext/
	rm -f *.jar
	java-pkg_jar-from jclasslib
}

src_compile() {
	cd ${S}/parser
	ant dist -lib $(java-config -p sablecc) || die "failed to create parser.jar"

	cp parser.jar ${S}/classes/ext/
	cd ${S}

	local antopts="-Dversion=${PV}"
	use jikes && antopts="${antopts} -Dbuild.compiler=jikes"
	ant ${antopts} dist || die "Compile failed"

	# Junits tests run inside a X window, disable.
	#if use junit ; then
	#	addwrite /root/.java/
	#	addwrite /etc/.java/
	#	ant ${antopts} test || die "Junit test failed"
	#fi
}

src_install() {
	# install jswat classes
	java-pkg_dojar build/dist/${P}/jswat.jar

	# prepare and install jswat script
	dobin ${FILESDIR}/jswat2

	# install documents
	dodoc BUGS.txt HISTORY.txt LICENSE.txt OLD_HISTORY.txt TODO.txt
	dohtml README.html
	use doc && java-pkg_dohtml -r docs
}
