# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/ganttproject/ganttproject-1.10.1.ebuild,v 1.4 2004/11/29 16:23:38 axxo Exp $

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
	echo 'java -classpath `java-config -p ganttproject` net.sourceforge.ganttproject.GanttProject "$@"' >> ganttproject
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
		cp ${FILESDIR}/${PV}-ganttproject.desktop ${D}/usr/share/gnome/apps/Office/ganttproject.desktop || die "failed too copy"
		cp data/resources/icons/ganttproject_32.ico ${D}/usr/share/pixmaps/ || die "failed to copy"
	fi
}
