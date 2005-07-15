# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/avalon-logkit-bin/avalon-logkit-bin-1.2.2.ebuild,v 1.7 2005/07/15 11:39:32 axxo Exp $

inherit java-pkg

DESCRIPTION="LogKit is an easy-to-use Java logging toolkit designed for secure, performance-oriented logging."
HOMEPAGE="http://avalon.apache.org/"
SRC_URI="mirror://apache/avalon/logkit/binaries/logkit-${PV}.tar.gz"
DEPEND=""
RDEPEND=">=virtual/jre-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64 ppc64"
IUSE="doc"

MY_P=${P/-bin}
S=${WORKDIR}/${MY_P/avalon-}-dev

src_install() {
	java-pkg_newjar ${MY_P/avalon-}.jar ${PN/-bin}.jar
	dodoc README.txt
	use doc && java-pkg_dohtml -r docs/*
}
