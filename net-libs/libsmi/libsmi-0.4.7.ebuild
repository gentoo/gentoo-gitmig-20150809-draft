# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libsmi/libsmi-0.4.7.ebuild,v 1.1 2008/03/02 14:19:44 pva Exp $

DESCRIPTION="A Library to Access SMI MIB Information"
SRC_URI="ftp://ftp.ibr.cs.tu-bs.de/pub/local/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.ibr.cs.tu-bs.de/projects/${PN}/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

src_install () {
	emake DESTDIR="${D}" install
	dodoc smi.conf-example ANNOUNCE ChangeLog README THANKS TODO doc/{*.txt,smi.dia,smi.dtd,smi.xsd}
}
