# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/sispmctl/sispmctl-2.7.ebuild,v 1.2 2008/06/01 09:11:18 wschlich Exp $

IUSE=""
DESCRIPTION="GEMBIRD SiS-PM control utility"
HOMEPAGE="http://sispmctl.sourceforge.net/"
SRC_URI="mirror://sourceforge/sispmctl/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
DEPEND=">=dev-libs/libusb-0.1.8"

src_compile() {
	local myconf="--enable-webless"
	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README ChangeLog NEWS
}
