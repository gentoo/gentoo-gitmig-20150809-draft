# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsensors/xsensors-0.47.ebuild,v 1.1 2005/06/16 20:41:34 augustus Exp $

DESCRIPTION="A hardware health information viewer, interface to lm-sensors"
HOMEPAGE="http://www.linuxhardware.org/xsensors"
SRC_URI="http://www.linuxhardware.org/xsensors/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	sys-apps/lm_sensors"

src_install() {
	einstall || die
	dodoc README ChangeLog AUTHORS TODO
}
