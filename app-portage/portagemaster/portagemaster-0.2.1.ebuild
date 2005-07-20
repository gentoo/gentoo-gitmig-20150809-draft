# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/portagemaster/portagemaster-0.2.1.ebuild,v 1.16 2005/07/20 16:25:57 axxo Exp $

inherit java-pkg

DESCRIPTION="A java portage browser and installer"
HOMEPAGE="http://portagemaster.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 sparc ppc"
IUSE="jikes"

DEPEND=">=virtual/jdk-1.4.1
	dev-java/ant-core
	jikes? ( >=dev-java/jikes-1.16 )"
RDEPEND=">=virtual/jre-1.4.1
		 virtual/x11"

S=${WORKDIR}/${PN}

src_compile() {
	if ! use jikes ; then
		sed -e 's!<property name="build.compiler" value="jikes"/>!<property	name="build.compiler" value="modern"/>!' -i build.xml
	fi
	ant || die
	sed -i \
		-e s:/usr/share/portagemaster/portagemaster.jar:/usr/share/portagemaster/lib/portagemaster-${PV}.jar: \
		src/portagemaster || die
}

src_install() {
	java-pkg_dojar packages/portagemaster-${PV}.jar
	dobin src/portagemaster
}
