# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/phex/phex-2.0.0.76.ebuild,v 1.2 2004/07/22 20:59:50 dholm Exp $

DESCRIPTION="java gnutella file-sharing application"
HOMEPAGE="http://phex.sourceforge.net/"
SRC_URI="mirror://sourceforge/phex/${P/-/_}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
RDEPEND=">=virtual/jdk-1.4
	virtual/x11"
S=${WORKDIR}/${P/-/_}

src_unpack() {
	unpack ${A}
	cd ${S}
	echo "PATH=/opt/${PN}/bin" >> ${S}/50${PN}
}

src_compile() {
	einfo "nothing to compile"
}

src_install() {
	insinto /opt/${PN}
	doins *.jar
	exeinto /opt/${PN}/bin
	newexe ${FILESDIR}/${PN}.sh ${PN}
	insinto /etc/env.d
	doins 50${PN}
	dohtml docs/readme/*
}
