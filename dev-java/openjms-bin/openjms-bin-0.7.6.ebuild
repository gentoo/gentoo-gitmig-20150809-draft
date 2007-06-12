# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/openjms-bin/openjms-bin-0.7.6.ebuild,v 1.15 2007/06/12 19:17:45 flameeyes Exp $

DESCRIPTION="Open Java Messaging System"
HOMEPAGE="http://openjms.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN/-bin/}/${P/-bin/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE="doc"

DEPEND=""
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/${PN/-bin/}-${PV}

src_compile() { :; }

src_install() {
	dodir /opt/${PN/-bin/}
	cp -r {bin,config,lib} ${D}/opt/${PN/-bin/}/
	use doc && cp -r {docs,src} ${D}/opt/${PN/-bin/}/

	fperms 755 /opt/${PN/-bin/}/bin/*
	newenvd ${FILESDIR}/${PV}/10${P/-bin/} 10${PN/-bin/}
	newinitd ${FILESDIR}/${PV}/rc2 openjms
	newconfd ${FILESDIR}/${PV}/conf openjms
}
