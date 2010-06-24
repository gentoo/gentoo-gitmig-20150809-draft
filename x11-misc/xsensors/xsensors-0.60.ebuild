# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsensors/xsensors-0.60.ebuild,v 1.8 2010/06/24 22:02:36 ssuominen Exp $

inherit autotools

DESCRIPTION="A hardware health information viewer, interface to lm-sensors."
HOMEPAGE="http://www.linuxhardware.org/xsensors/"
SRC_URI="http://www.linuxhardware.org/xsensors/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	<sys-apps/lm_sensors-3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}

	cd "${S}"
	sed -i -e 's,-Werror,,g' configure.in || die
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO
}
