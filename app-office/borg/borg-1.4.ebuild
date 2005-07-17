# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/borg/borg-1.4.ebuild,v 1.4 2005/07/17 11:46:05 axxo Exp $

inherit java-pkg

DESCRIPTION="Calendar and task tracker, written in Java"
HOMEPAGE="http://borg-calendar.sourceforge.net/"
SRC_URI="mirror://sourceforge/borg-calendar/borg_src_${PV}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	dev-java/ant-core"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/borg_src/BORG Calendar Common/"

src_compile() {
	cd ant
	local antflags="borg-jar"
	ant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	echo "#!/bin/sh" > ${PN}
	echo "cd /usr/share/${PN}" >> ${PN}
	echo "\${JAVA_HOME}/bin/java -jar \$(java-config -p borg) \$*" >> ${PN}

	dobin ${PN}
}
