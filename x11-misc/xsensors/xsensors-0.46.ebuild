# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsensors/xsensors-0.46.ebuild,v 1.1 2004/11/20 05:21:59 augustus Exp $

DESCRIPTION="A hardware health information viewer, interface to lm-sensors"
HOMEPAGE="http://www.linuxhardware.org/xsensors"
SRC_URI="http://www.linuxhardware.org/xsensors/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	sys-apps/lm-sensors"

src_install() {
	einstall || die
	dodoc README ChangeLog AUTHORS TODO
}
