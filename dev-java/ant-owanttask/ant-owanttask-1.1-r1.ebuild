# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-owanttask/ant-owanttask-1.1-r1.ebuild,v 1.2 2004/10/17 07:22:56 absinthe Exp $

inherit java-pkg

DESCRIPTION="ObjectWeb's Ant tasks"
HOMEPAGE="http://monolog.objectweb.org"
SRC_URI="http://www.gentoo.org/~karltk/java/distfiles/owanttask-${PV}-gentoo.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""
DEPEND="virtual/jdk"
RDEPEND="virtual/jre
	dev-java/ant"
S=${WORKDIR}/owanttask-${PV}

src_compile() {
	ant jar || die
}

src_install() {
	java-pkg_dojar output/lib/ow_util_ant_tasks.jar
	dodir /usr/share/ant-core/lib
	dosym /usr/share/ant-owanttask/lib/ow_util_ant_tasks.jar /usr/share/ant-core/lib/
}

