# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jsch/jsch-0.1.13.ebuild,v 1.6 2004/03/22 20:07:42 dholm Exp $

inherit java-pkg

DESCRIPTION="JSch is a pure Java implementation of SSH2."
HOMEPAGE="http://www.jcraft.com/jsch/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV}.zip"

LICENSE="jcraft"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="doc jikes"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-1.4
	>=dev-java/jzlib-1.0.3
	jikes? ( >=dev-java/jikes-1.17 )"
RDEPEND=">=virtual/jdk-1.4"

src_compile() {
	epatch ${FILESDIR}/build.xml-dstamp.patch.gz

	local myc

	if [ -n "`use jikes`" ] ; then
		myc="${myc} -Dbuild.compiler=jikes"
	fi

	ANT_OPTS=${myc} ant || die "Failed Compiling"
}

src_install() {
	java-pkg_dojar dist/lib/jsch.jar || die "Failed Installing"
	dodoc LICENSE.txt README ChangeLog
	cp -r examples ${D}/usr/share/doc/${PN}-${PV}
}
