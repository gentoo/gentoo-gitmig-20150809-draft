# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsensors/xsensors-0.70.ebuild,v 1.6 2010/10/04 12:55:15 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="A hardware health information viewer, interface to lm-sensors."
HOMEPAGE="http://www.linuxhardware.org/xsensors/"
SRC_URI="http://www.linuxhardware.org/xsensors/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	>=sys-apps/lm_sensors-3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gtk220.patch

	sed -i \
		-e '/-DG.*_DISABLE_DEPRECATED/d' \
		-e 's:-Werror:-Wall:' \
		src/Makefile.am || die

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
}
