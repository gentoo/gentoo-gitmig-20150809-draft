# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsensors/xsensors-0.20.ebuild,v 1.1 2003/07/12 17:44:43 avenj Exp $

DESCRIPTION="A hardware health information viewer, interface to lm-sensors"
HOMEPAGE="http://www.linuxhardware.org/xsensors"
SRC_URI="http://www.linuxhardware.org/xsensors/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	sys-apps/lm-sensors"

S=${WORKDIR}/${P}

src_install() {
	einstall || die
	dodoc README ChangeLog AUTHORS TODO
}
