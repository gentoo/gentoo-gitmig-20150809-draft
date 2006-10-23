# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-kdepim/libopensync-plugin-kdepim-0.19.ebuild,v 1.1 2006/10/23 19:35:02 peper Exp $

inherit qt3

DESCRIPTION="OpenSync Kdepim Plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://dev.gentooexperimental.org/~peper/distfiles/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="arts"

DEPEND=">=app-pda/libopensync-0.19
	kde-base/libkcal"

RDEPEND="${DEPEND}"

src_compile() {
	econf $(use_with arts) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog COPYING NEWS README
}
