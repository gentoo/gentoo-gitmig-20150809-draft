# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/portagemaster/portagemaster-0.2.0.ebuild,v 1.2 2003/09/07 03:12:20 msterret Exp $

DESCRIPTION="A java portage browser and installer"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://portagemaster.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc sparc"
IUSE="jikes"

DEPEND=">=dev-java/sun-jdk-1.4.1-r5
	>=dev-java/ant-1.5.1-r3
	jikes? ( >=dev-java/jikes-1.16 )"
RDEPEND=">=dev-java/sun-jdk-1.4.1-r5"

S=${WORKDIR}/${PN}

pkg_setup() {
	local foo
	foo=`java-config --java-version 2>&1 | grep "1.4."`
	if [ -z "$foo" ] ; then
		eerror "You have to set the 1.4.1 JDK as your system default to compile this package."
		einfo "Use java-config --set-system-vm=sun-jdk-1.4.1 (or more recent) to set it."
		exit 1
	fi
}

src_unpack() {
	unpack ${A}
}

src_compile() {
	if [ -z "`use jikes`" ] ; then
		einfo "Configuring build for Jikes"
		cp build.xml build.xml.orig
		sed 's!<property name="build.compiler" value="jikes"/>!<property name="build.compiler" value="modern"/>!' < build.xml.orig > build.xml
	fi
	ant
	cp src/portagemaster src/portagemaster.orig
	sed -e s:/usr/share/portagemaster/portagemaster.jar:/usr/share/portagemaster/lib/portagemaster-${PV}.jar: \
		< src/portagemaster.orig \
		> src/portagemaster || die
}

src_install() {
	dojar packages/portagemaster-${PV}.jar
	dobin src/portagemaster
}
