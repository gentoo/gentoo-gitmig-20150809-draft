# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsensors/xsensors-0.60.ebuild,v 1.1 2007/11/05 04:51:12 omp Exp $

DESCRIPTION="A hardware health information viewer, interface to lm-sensors."
HOMEPAGE="http://www.linuxhardware.org/xsensors/"
SRC_URI="http://www.linuxhardware.org/xsensors/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2
	sys-apps/lm_sensors"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO
}
