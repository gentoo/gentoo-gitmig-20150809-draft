# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/projectx/projectx-0.82.0.00.ebuild,v 1.1 2005/03/25 02:41:21 luckyduck Exp $

inherit eutils java-pkg

MY_PN="ProjectX"
MY_P="${MY_PN}_Source_${PV}"

DESCRIPTION="Converts, splits and demuxes DVB and other MPEG recordings"
HOMEPAGE="http://sourceforge.net/projects/project-x/"
SRC_URI="mirror://sourceforge/project-x/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.4
	dev-java/commons-net
	dev-java/oro"

IUSE="doc jikes source"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}

	cp ${FILESDIR}/${PV}-build.xml ./build.xml
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} docs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compilation failed"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	# generate a startup script
	echo "#!/bin/sh" > ${PN}
	echo "\$(java-config -J) -cp \$(java-config -p projectx,oro) net.sourceforge.dvb.projectx.common.X" >> ${PN}

	dobin ${PN}

	if use doc; then
		java-pkg_dohtml -r apidocs/ htmls/*
		dodoc *.txt
	fi
	use source && java-pkg_dosrc src/*
}
