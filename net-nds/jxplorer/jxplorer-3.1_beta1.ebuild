# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/jxplorer/jxplorer-3.1_beta1.ebuild,v 1.3 2004/08/30 18:48:18 zx Exp $

DESCRIPTION="A fully functional ldap browser written in java."
HOMEPAGE="http://jxplorer.org/"
SRC_URI="mirror://sourceforge/${PN}/JXv3.1b1deploy.tar.bz2"
LICENSE="CAOSL"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/jre"
RESTRICT="nomirror"

S=${WORKDIR}/${PN}

src_compile() { :; }

src_install() {
	dodir /opt/jxplorer
	cp -R ${S}/* ${D}/opt/jxplorer
	chmod 755 ${D}/opt/${PN}/${PN}.sh
	dodir /opt/bin
	ln -sf ${D}/opt/${PN}/${PN}.sh ${D}/opt/bin/${PN}
}
