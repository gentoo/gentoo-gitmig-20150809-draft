# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/phex/phex-2.6.4.89.ebuild,v 1.1 2005/09/26 21:09:27 mkay Exp $

inherit java-pkg

DESCRIPTION="java gnutella file-sharing application"
HOMEPAGE="http://phex.sourceforge.net/"
SRC_URI="mirror://sourceforge/phex/${P/-/_}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jdk-1.4
	virtual/x11
	=dev-java/commons-httpclient-3.0*
	dev-java/commons-logging
	>=dev-java/jgoodies-forms-1.0.5
	>=dev-java/jgoodies-looks-1.3.1"

S=${WORKDIR}/${P/-/_}

src_install() {
	cd ${S}
	java-pkg_dojar phex.jar jaxb.jar

	exeinto /usr/bin
	newexe ${FILESDIR}/${P}.sh ${PN}

	dohtml docs/readme/*
}
