# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/openjms-bin/openjms-bin-0.7.6.ebuild,v 1.8 2005/03/23 13:52:25 gustavoz Exp $

SLOT="0"
LICENSE="GPL-2"
DESCRIPTION="Open Java Messaging System"
HOMEPAGE="http://openjms.sourceforge.net/"
DEPEND="virtual/libc"
RDEPEND="virtual/jdk"
KEYWORDS="~x86 ~amd64 ppc64 ~sparc"
SRC_URI="mirror://sourceforge/${PN/-bin/}/${P/-bin/}.tar.gz"
IUSE="doc"

S=${WORKDIR}/${PN/-bin/}-${PV}

src_compile() { :; }

src_install() {
	dodir /opt/${PN/-bin/}
	cp -r {bin,config,lib} ${D}/opt/${PN/-bin/}/
	use doc && cp -r {docs,src} ${D}/opt/${PN/-bin/}/

	fperms 755 /opt/${PN/-bin/}/bin/*
	insinto /etc/env.d/
	newins ${FILESDIR}/${PV}/10${P/-bin/} 10${PN/-bin/}
	exeinto /etc/init.d/
	newexe ${FILESDIR}/${PV}/rc2 openjms
	insinto /etc/conf.d
	newins ${FILESDIR}/${PV}/conf openjms
}
