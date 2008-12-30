# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tpconfig/tpconfig-3.1.3.ebuild,v 1.13 2008/12/30 20:29:22 angelos Exp $

inherit toolchain-funcs

DESCRIPTION="Touchpad config for ALPS and Synaptics TPs. Controls tap/click behaviour"
HOMEPAGE="http://www.compass.com/synaptics/"
SRC_URI="http://www.compass.com/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

src_compile() {
	econf
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin tpconfig || die "dobin failed!"
	dodoc README AUTHORS NEWS INSTALL
	doinitd "${FILESDIR}"/tpconfig
	newconfd "${FILESDIR}"/tpconfig.conf tpconfig
}
