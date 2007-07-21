# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/phex/phex-3.0.0.99.ebuild,v 1.2 2007/07/21 09:47:27 betelgeuse Exp $

inherit java-pkg-2

DESCRIPTION="java gnutella file-sharing application"
HOMEPAGE="http://phex.sourceforge.net/"
SRC_URI="mirror://sourceforge/phex/${P/-/_}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jdk-1.5
	=dev-java/commons-httpclient-3.0*
	>=dev-java/commons-logging-1.1
	>=dev-java/jgoodies-forms-1.0.5
	>=dev-java/jgoodies-looks-2.0"

S=${WORKDIR}/${P/-/_}

src_install() {
	java-pkg_dojar lib/phex.jar

	exeinto /usr/bin
	newexe ${FILESDIR}/${P}.sh ${PN}

	dohtml docs/readme/*
}
