# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdepend/jdepend-2.6.ebuild,v 1.1 2004/01/03 19:31:55 strider Exp $

DESCRIPTION="JDepend traverses Java class file directories and generates design quality metrics for each Java package."
HOMEPAGE="http://www.clarkware.com/software/JDepend.html"
SRC_URI="http://www.clarkware.com/software/${PN}-${PV}.zip"

LICENSE="jdepend"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc jikes"

DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4
	jikes? ( >=dev-java/jikes-1.17 )"
RDEPEND=">=virtual/jdk-1.3"

#S=${WORKDIR}/jakarta-oro-${PV}

#TODO Do junit testing but resolve the circular dependency we have with ant.
src_compile() {
	local myc

	if [ -n "`use jikes`" ] ; then
		myc="${myc} -Dbuild.compiler=jikes"
	fi

#	use junit && export CLASSPATH=$CLASSPATH:`java-config --classpath=junit`

	ANT_OPTS=${myc} ant jar || die "Failed Compiling"

#	if [ -n "`use junit`" ] ; then
#		ant test || die "Failed Testing Packages Integrity"
#	fi
}

src_install() {
	dojar lib/jdepend.jar || die "Failed Installing"
	dodoc LICENSE README

	if [ -n "`use doc`" ]; then
		dohtml docs/JDepend.html
		cp -r docs/api ${D}/usr/share/doc/${PN}-${PV}/html
		cp -r docs/images ${D}/usr/share/doc/${PN}-${PV}/html
	fi
}
