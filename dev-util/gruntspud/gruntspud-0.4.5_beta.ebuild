# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gruntspud/gruntspud-0.4.5_beta.ebuild,v 1.1 2004/04/11 22:29:16 zx Exp $

inherit java-pkg

DESCRIPTION="Gruntspud is a graphical CVS client written in Java."
HOMEPAGE="http://gruntspud.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV/_/-}-src.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=virtual/jdk-1.3
		dev-java/ant
		sys-apps/sed
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.3"

S="${WORKDIR}/${PN}-${PV/_/-}"

src_unpack() {
	unpack ${A}
	# Dirty workaround
	cd ${S}
	sed -i 's:compile_standalone,javahelp:compile_standalone:' build.xml
}

src_compile() {
	local antflags="dist_standalone"
	ant ${antflags} || die "compilation problem"
}

src_install() {
	cd ${S}/dist/lib
	mv GruntspudSA.jar ${PN}.jar
	java-pkg_dojar ${PN}.jar

	echo "#!/bin/sh" > ${PN}
	echo "cd /usr/share/${PN}" >> ${PN}
	echo "java -jar lib/${PN}.jar" >> ${PN}
	dobin ${PN}
}

