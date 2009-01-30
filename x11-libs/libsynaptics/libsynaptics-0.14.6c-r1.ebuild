# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libsynaptics/libsynaptics-0.14.6c-r1.ebuild,v 1.3 2009/01/30 20:41:18 maekke Exp $

inherit eutils

DESCRIPTION="library for accessing synaptics touchpads"
HOMEPAGE="http://qsynaptics.sourceforge.net/"
SRC_URI="http://qsynaptics.sourceforge.net/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND=">=x11-drivers/synaptics-0.14.4"

src_unpack() {
	unpack ${A} || die
	cd "${S}" || die
	epatch "${FILESDIR}/libsynaptics-0.14.6c-r1-gcc-4-3-0.patch" || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog README TODO
}
