# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/systray4j/systray4j-2.4.ebuild,v 1.13 2006/01/02 00:13:41 nichoj Exp $

inherit kde java-pkg eutils

DESCRIPTION="Library and daemon to give java applications access to the KDE tray"
HOMEPAGE="http://systray.sourceforge.net/"
SRC_URI="mirror://sourceforge/systray/${P}-kde3-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc amd64 ppc ppc64"
# disable jikes support until bug #89711
IUSE=""

RDEPEND=">=virtual/jre-1.3
	=kde-base/kdelibs-3*"

DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	=kde-base/kdelibs-3*
	sys-apps/sed"

need-kde 3

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i -e 's:^JDK_PATH = .*$:JDK_PATH = $(JAVA_HOME):g' \
	       -e 's:^QT3_PATH = .*$:QT3_PATH = $(QTDIR):g' \
	       -e 's:^KDE3_PATH = .*$:KDE3_PATH = $(KDEDIR):g' \
	       -e 's:-L/opt/kde3/lib:-L$(KDEDIR)/lib -L$(QTDIR)/lib:g' \
		${S}/kde/Makefile || die "Could not edit Makefile"

	epatch ${FILESDIR}/${P}-fPIC.patch
}

src_compile() {
	cd ${S}/kde
	emake || die "Failure compiling KDE daemon."

	mkdir ${S}/java/classes.gentoo
	cd ${S}/java/sources
	for source in $(find . -name *.java); do
		javac -d ${S}/java/classes.gentoo ${source}
	done

	cd ${S}/java/classes.gentoo
	jar cvf systray4j.jar snoozesoft || die "failed to build jar"
}

src_install() {
	dodoc README TODO

	java-pkg_dojar ${S}/java/classes.gentoo/systray4j.jar

	cd ${S}/kde
	dolib.so libsystray4j.so
}
