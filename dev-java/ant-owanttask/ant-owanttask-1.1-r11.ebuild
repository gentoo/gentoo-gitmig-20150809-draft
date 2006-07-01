# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-owanttask/ant-owanttask-1.1-r11.ebuild,v 1.1 2006/07/01 14:22:53 nichoj Exp $

inherit java-ant-2 java-pkg-2

DESCRIPTION="ObjectWeb's Ant tasks"
HOMEPAGE="http://monolog.objectweb.org"
SRC_URI="http://www.gentoo.org/~karltk/java/distfiles/owanttask-${PV}-gentoo.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4
	dev-java/ant-core"
S=${WORKDIR}/owanttask-${PV}

src_compile() {
	eant jar
}

src_install() {
	java-pkg_dojar output/lib/ow_util_ant_tasks.jar
	dodir /usr/share/ant-core/lib
	dosym /usr/share/ant-owanttask/lib/ow_util_ant_tasks.jar /usr/share/ant-core/lib/
}

