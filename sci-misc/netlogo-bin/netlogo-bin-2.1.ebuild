# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/netlogo-bin/netlogo-bin-2.1.ebuild,v 1.1 2005/03/16 16:02:44 humpback Exp $

inherit eutils java-pkg
RESTRICT="fetch"
MY_PN="netlogo"
MY_P=${MY_PN}-${PV}
DESCRIPTION="NetLogo cross-platform multi-agent programmable modeling environment"

HOMEPAGE="http://ccl.northwestern.edu/netlogo/"
SRC_URI="${MY_P}.tar.gz"
LICENSE="netlogo"
SLOT="0"
KEYWORDS="~x86"
DEPEND="app-arch/unzip
		>=virtual/jdk-1.4"

RDEPEND=">=virtual/jre-1.4"

IUSE=""

S=${WORKDIR}/${MY_P}

pkg_nofetch() {
	einfo "Please go to ${HOMEPAGE} and download ${A} "
	einfo "Have a look at http://ccl.northwestern.edu/netlogo/docs/copyright.html"
	einfo "before using this software"
}



src_install() {
	java-pkg_dojar *.jar
	java-pkg_dojar extensions/*.jar

	dohtml -r docs/*
	insinto /usr/share/${PN}/models
	doins -r models/*


	insinto /usr/share/pixmaps
	doins  ${FILESDIR}/netlogo.gif

	exeinto /opt/bin
	newexe ${FILESDIR}/netlogo.sh netlogo

	make_desktop_entry netlogo "NetLogo" /usr/share/pixmaps/netlogo.gif
}
