# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jzlib/jzlib-1.0.3.ebuild,v 1.2 2004/02/15 09:27:04 dholm Exp $

DESCRIPTION="JZlib is a re-implementation of zlib in pure Java."
HOMEPAGE="http://www.jcraft.com/jzlib/"
SRC_URI="http://www.jcraft.com/${PN}/${PN}-${PV}.tar.gz"

LICENSE="jcraft"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="doc jikes"
RESTRICT="nomirror"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-1.4
	jikes? ( >=dev-java/jikes-1.17 )"
RDEPEND=">=virtual/jdk-1.4"

src_compile() {
	cp ${FILESDIR}/jzlib_build.xml build.xml
	mkdir src
	mv com/ src/
	local myc

	if [ -n "`use jikes`" ] ; then
		myc="${myc} -Dbuild.compiler=jikes"
	fi

	ANT_OPTS=${myc} ant || die "Failed Compiling"
}

src_install() {
	mv dist/lib/jzlib-${PV}.jar dist/lib/jzlib.jar
	dojar dist/lib/jzlib.jar || die "Failed Installing"
	dodoc LICENSE.txt README ChangeLog
	cp -r example ${D}/usr/share/doc/${PN}-${PV}
}
