# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/netlogo-bin/netlogo-bin-3.1.3.ebuild,v 1.5 2009/04/17 20:03:22 caster Exp $

inherit eutils java-pkg-2
#RESTRICT="fetch"
MY_PN="netlogo"
MY_P=${MY_PN}-${PV}
DESCRIPTION="NetLogo cross-platform multi-agent programmable modeling environment"

HOMEPAGE="http://ccl.northwestern.edu/netlogo/"
SRC_URI="http://ccl.northwestern.edu/netlogo/${PV}/${MY_P}.tar.gz"
LICENSE="netlogo"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="app-arch/unzip
		>=virtual/jdk-1.4"

RDEPEND=">=virtual/jre-1.4"

IUSE=""

S=${WORKDIR}/${MY_P}

src_install() {
	java-pkg_dojar *.jar
	java-pkg_dojar extensions/*.jar
	java-pkg_dojar lib/*.jar

	dohtml -r docs/*
	insinto /usr/share/${PN}/models
	doins -r models/*

	insinto /usr/share/pixmaps
	doins  ${FILESDIR}/netlogo.gif

	exeinto /opt/bin
	newexe ${FILESDIR}/netlogo.sh netlogo

	make_desktop_entry netlogo "NetLogo" /usr/share/pixmaps/netlogo.gif

}
