# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jswat/jswat-2.34.ebuild,v 1.2 2005/07/15 22:10:03 axxo Exp $

inherit java-pkg eutils

DESCRIPTION="Extensible graphical Java debugger"
HOMEPAGE="http://www.bluemarsh.com/java/jswat"
SRC_URI="mirror://sourceforge/jswat/${PN}-src-${PV}.zip"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86 -ppc"
IUSE="doc jikes" #junit"

RDEPEND=">=virtual/jdk-1.4
	dev-java/jclasslib"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	>=dev-java/ant-1.6
	app-arch/unzip
	dev-java/sablecc-anttask
	dev-java/sablecc
	jikes? ( dev-java/jikes )"
	#junit? ( dev-java/junit )"

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
	java-pkg_dojar build/dist/jswat.jar

	dobin ${FILESDIR}/jswat2

	dodoc BUGS.txt HISTORY.txt OLD_HISTORY.txt TODO.txt
	dohtml README.html
	use doc && java-pkg_dohtml -r docs
}
