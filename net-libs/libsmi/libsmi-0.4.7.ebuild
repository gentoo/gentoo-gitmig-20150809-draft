# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libsmi/libsmi-0.4.7.ebuild,v 1.3 2008/03/04 12:52:41 armin76 Exp $

DESCRIPTION="A Library to Access SMI MIB Information"
SRC_URI="ftp://ftp.ibr.cs.tu-bs.de/pub/local/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.ibr.cs.tu-bs.de/projects/${PN}/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

src_install () {
	emake DESTDIR="${D}" install
	dodoc smi.conf-example ANNOUNCE ChangeLog README THANKS TODO doc/{*.txt,smi.dia,smi.dtd,smi.xsd}
}
