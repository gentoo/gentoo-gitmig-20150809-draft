# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mnet/mnet-0.5.1.22.ebuild,v 1.1 2002/08/15 14:38:48 cybersystem Exp $

S="${WORKDIR}/${PN}/${PN}"

DESCRIPTION="Mnet is a universal file space. It is formed by an emergent network of autonomous nodes which self-organize to make the network robust and efficient."
SRC_URI="mirror://sourceforge/${PN}/${P}-linux-i386.tgz"
HOMEPAGE="http://mnet.sourceforge.net/"

RDEPEND="dev-lang/python"
LICENSE="LGPL"
KEYWORDS="x86"
SLOT="0"
src_compile() {
    einfo "Nothing to compile for ${P}."
}
src_install() {
	rm -rf ${S}/wxBroker
	rm -rf ${S}/mnmods
	rm -rf ${S}/MacOSX
	rm -rf ${S}/rmnlib
	rm -f ${S}/Broker.bat
	rm -f ${S}/GNUmakefile
	dodoc ${S}/COPYING ${S}/CREDITS ${S}/ChangeLog ${S}/overview.txt ${S}/hackerdocs/*
	rm -rf ${S}/COPYING ${S}/CREDITS ${S}/ChangeLog ${S}/overview.txt ${S}/hackerdocs/* ${S}/tarexclude.txt 
	dodir /opt/mnet
	cp -r ${S}/* ${D}/opt/mnet
	insinto /etc/env.d
	doins ${FILESDIR}/97mnet
}
