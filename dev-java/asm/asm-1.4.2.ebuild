# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/asm/asm-1.4.2.ebuild,v 1.2 2004/03/30 15:40:23 dholm Exp $

inherit java-pkg

DESCRIPTION="Bytecode manipulation framework for Java"
HOMEPAGE="http://asm.objectweb.org"
SRC_URI="http://download.forge.objectweb.org/asm/asm-1.4.2.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=virtual/jdk-1.3
	dev-java/ant
	dev-java/ant-owanttask"
RDEPEND=">=virtual/jre-1.3"

src_unpack() {
	unpack ${A}
	cd ${S}
	echo "objectweb.ant.tasks.path /usr/share/ant-owanttask/lib/ow_util_ant_tasks.jar" \
		>> build.properties
}

src_compile() {
	ant jar || die
	if $(use doc) ; then
		ant jdoc || die
	fi
}

src_install() {
	for x in output/dist/lib/*.jar ; do
		java-pkg_dojar $x
	done
	use doc &&
		dohtml -r output/dist/doc/javadoc/user/*
}

