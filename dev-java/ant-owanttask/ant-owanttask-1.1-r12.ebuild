# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-owanttask/ant-owanttask-1.1-r12.ebuild,v 1.2 2007/01/30 00:05:12 caster Exp $

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="ObjectWeb's Ant tasks"
HOMEPAGE="http://monolog.objectweb.org"
SRC_URI="http://www.gentoo.org/~karltk/java/distfiles/owanttask-${PV}-gentoo.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4
	>=dev-java/ant-core-1.7.0
	dev-java/xalan"
S=${WORKDIR}/owanttask-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-classpath.patch

	cp -f ${FILESDIR}/MultipleCopy.java src/org/objectweb/util/ant

	mkdir lib
	cd lib
	java-pkg_jar-from ant-core ant.jar
	java-pkg_jar-from xalan
}

src_compile() {
	eant jar
}

src_install() {
	java-pkg_dojar output/lib/ow_util_ant_tasks.jar
}

pkg_preinst() {
	ewarn "The MultipleCopy task is not compatible with ant-1.7.0 and newer"
	ewarn "Attempt to use it will break building."
}
