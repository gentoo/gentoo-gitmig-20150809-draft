# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/xpg/xpg-0.1-r1.ebuild,v 1.1 2006/07/17 14:51:17 nichoj Exp $

inherit java-pkg-2

DESCRIPTION="GUI for PostgreSQL written in Java"
HOMEPAGE="http://www.kazak.ws/xpg/"
SRC_URI="mirror://gentoo/xpg-current.tar.gz
	mirror://gentoo/xpg-icons.tar.gz"
S="${WORKDIR}/xpg-current"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s/javac/javac $(java-pkg_javac-args)/" Makefile || die "sed failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	cd ${S}
	java-pkg_dojar bin/*.jar
	dodir /usr/share/xpg /usr/share/pixmaps/
	cp -Rdp styles ${D}/usr/share/xpg/
	cp -Rdp ${WORKDIR}/*.jpg ${D}/usr/share/pixmaps/
	cp -Rdp ${WORKDIR}/*.xpm ${D}/usr/share/pixmaps/
	dohtml -r doc/*

	java-pkg_dolauncher ${PN} --jar xpg.jar --java_args '-Dxpghome=/usr/share/xpg'
}
