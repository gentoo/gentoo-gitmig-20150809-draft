# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/portagemaster/portagemaster-0.2.1.ebuild,v 1.7 2004/03/22 19:53:01 dholm Exp $

DESCRIPTION="A java portage browser and installer"
HOMEPAGE="http://portagemaster.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 sparc ~ppc"
IUSE="jikes"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-1.5.1-r3
	jikes? ( >=dev-java/jikes-1.16 )"
RDEPEND=">=virtual/jre-1.4
		 x11-base/xfree"

S=${WORKDIR}/${PN}

pkg_setup() {
	local foo
	foo=`java-config --java-version 2>&1 | grep "1.4."`
	if [ -z "$foo" ] ; then
		eerror "You have to set the 1.4.1 JDK as your system default to compile this package."
		einfo "Use java-config --set-system-vm=sun-jdk-1.4.1 (or more recent) to set it."
		die
	fi
}

src_compile() {
	if [ -z "`use jikes`" ] ; then
		einfo "Configuring build for Jikes"
		cp build.xml build.xml.orig
		sed 's!<property name="build.compiler" value="jikes"/>!<property name="build.compiler" value="modern"/>!' < build.xml.orig > build.xml
	fi
	ant
	sed -i \
		-e s:/usr/share/portagemaster/portagemaster.jar:/usr/share/portagemaster/lib/portagemaster-${PV}.jar: \
		src/portagemaster || die
}

src_install() {
	dojar packages/portagemaster-${PV}.jar
	dobin src/portagemaster
}
