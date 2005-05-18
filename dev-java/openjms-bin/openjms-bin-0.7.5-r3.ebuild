# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/openjms-bin/openjms-bin-0.7.5-r3.ebuild,v 1.9 2005/05/18 13:36:04 axxo Exp $

SLOT=0
LICENSE="GPL-2"
DESCRIPTION="Open Java Messaging System"
HOMEPAGE="http://openjms.sourceforge.net/"
DEPEND="virtual/libc"
RDEPEND="virtual/jdk"
KEYWORDS="~x86 ~amd64"
IUSE=""
SRC_URI="mirror://sourceforge/${PN/-bin/}/${P/-bin/}.tgz"

src_unpack() {
	einfo "Nothing to unpack"
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dodir /opt
	cd ${D}/opt
	unpack ${A}
	fperms 755 /opt/${P/-bin/}/bin/*
	insinto /etc/env.d/
	newins ${FILESDIR}/10${P/-bin/} 10${PN/-bin/}
	exeinto /etc/init.d/
	newexe ${FILESDIR}/rc2 openjms
	insinto /etc/conf.d
	newins ${FILESDIR}/conf openjms
}
