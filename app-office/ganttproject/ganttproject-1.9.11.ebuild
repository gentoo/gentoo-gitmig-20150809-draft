# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/ganttproject/ganttproject-1.9.11.ebuild,v 1.5 2004/11/03 11:51:47 axxo Exp $

inherit eutils java-pkg

IUSE="doc gnome"

DESCRIPTION="Project Management tool to create Gantt Charts"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.zip"
HOMEPAGE="http://ganttproject.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	>=dev-java/ant-1.5.4"

src_compile() {
	ant || die "Failed building classes"
	if use doc; then
		ant javadocs || die "Failed building javadocs"
	fi
	echo "#! /bin/sh" > ganttproject
	echo "export CLASSPATH=$(java-config -p ganttproject)" >> ganttproject
	echo "java net.sourceforge.ganttproject.GanttProject $@" >> ganttproject
}

src_install () {
	java-pkg_dojar build/*.jar
	java-pkg_dojar lib/optional/*.jar
	exeinto /usr/bin
	doexe ganttproject
	dodoc AUTHORS  COPYING  README
	if use doc; then
		java-pkg_dohtml -r build/docs/api
	fi
	if use gnome; then
		mkdir -p ${D}/usr/share/gnome/apps/Office/
		mkdir -p ${D}/usr/share/pixmaps
		cp ${FILESDIR}/ganttproject.desktop ${D}/usr/share/gnome/apps/Office/
		cp data/resources/icons/ganttproject.gif ${D}/usr/share/pixmaps
	fi
}
