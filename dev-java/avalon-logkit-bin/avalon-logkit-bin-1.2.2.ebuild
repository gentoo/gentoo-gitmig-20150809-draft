# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/avalon-logkit-bin/avalon-logkit-bin-1.2.2.ebuild,v 1.1 2004/07/30 18:39:42 axxo Exp $

inherit java-pkg

DESCRIPTION="LogKit is an easy-to-use Java logging toolkit designed for secure, performance-oriented logging."
HOMEPAGE="http://avalon.apache.org/"
SRC_URI="mirror://apache/avalon/logkit/binaries/logkit-${PV}.tar.gz"
DEPEND=">=virtual/jre-1.3"
RDEPEND=">=virtual/jre-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE="doc"

S=${WORKDIR}/${P/avalon-}-dev

src_compile() { :; }

src_install() {
	mv ${P/avalon-}.jar ${PN}.jar
	java-pkg_dojar ${PN}.jar || die "Unable to Install"
	dodoc README.txt
	use doc && dohtml -r docs/*
}
