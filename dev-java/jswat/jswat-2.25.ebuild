# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jswat/jswat-2.25.ebuild,v 1.7 2005/04/03 18:25:41 weeve Exp $

inherit java-pkg eutils

DESCRIPTION="Extensible graphical Java debugger"
HOMEPAGE="http://www.bluemarsh.com/java/jswat"
SRC_URI="mirror://sourceforge/jswat/${PN}-src-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86 ~sparc -ppc ~amd64"
IUSE="doc jikes" #junit"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-1.5
	app-arch/unzip
	jikes? ( dev-java/jikes )"
	#junit? ( dev-java/junit )"
RDEPEND=">=virtual/jdk-1.4"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/build.xml.patch
}

src_compile() {
	local antopts="-Dversion=${PV}"
	use jikes && antopts="${antopts} -Dbuild.compiler=jikes"
	ant ${antopts} dist || die "Compile failed"

	# Junits tests run inside a X window, disable.
	#if use junit ; then
	#	addwrite /root/.java/
	#	einfo "Running JUnit tests, this may take awhile ..."
	#	ant ${antopts} test || die "Junit test failed"
	#fi
}

src_install() {
	# install jswat classes
	java-pkg_dojar build/dist/*/*.jar

	# prepare and install jswat script
	dobin ${FILESDIR}/jswat2

	# install documents
	dodoc BUGS.txt HISTORY.txt LICENSE.txt OLD_HISTORY.txt TODO.txt
	dohtml README.html
	use doc && java-pkg_dohtml -r docs
}
