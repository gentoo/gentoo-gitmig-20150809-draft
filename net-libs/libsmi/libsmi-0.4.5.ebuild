# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libsmi/libsmi-0.4.5.ebuild,v 1.1 2006/09/15 06:26:43 robbat2 Exp $

DESCRIPTION="A Library to Access SMI MIB Information"
SRC_URI="ftp://ftp.ibr.cs.tu-bs.de/pub/local/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.ibr.cs.tu-bs.de/projects/${PN}/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

src_compile() {
	econf
	emake || die
}

src_install () {
	einstall pibdir=${D}/usr/share/pibs mibdir=${D}/usr/share/mibs
	dodoc smi.conf-example ANNOUNCE ChangeLog COPYING README THANKS TODO
	cd ${S}/doc
	dodoc *.txt smi.dia smi.dtd smi.xsd
}
