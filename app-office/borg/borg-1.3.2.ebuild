# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/borg/borg-1.3.2.ebuild,v 1.2 2004/10/05 20:30:56 axxo Exp $

inherit java-pkg

DESCRIPTION="Calendar and task tracker, written in Java"
HOMEPAGE="http://borg-calendar.sourceforge.net/"
SRC_URI="mirror://sourceforge/borg-calendar/borg_src_${PV}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-1.4.1"
RDEPEND=">=virtual/jdk-1.4"

S=${WORKDIR}/borg_src

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
