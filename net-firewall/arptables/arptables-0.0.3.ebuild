# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/arptables/arptables-0.0.3.ebuild,v 1.8 2005/09/22 03:03:35 vapier Exp $

EXT=-2
DESCRIPTION="set up, maintain, and inspect the tables of ARP rules in the Linux kernel"
HOMEPAGE="http://ebtables.sourceforge.net/"
SRC_URI="mirror://sourceforge/ebtables/${PN}-v${PV}${EXT}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

S=${WORKDIR}/${PN}-v${PV}${EXT}

src_compile() {
	emake || die
}

src_install() {
	dodir /sbin
	einstall PREFIX=${D}/ MANDIR=${D}/usr/share/man/ || die
}
