# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-rra/synce-rra-0.8.4-r1.ebuild,v 1.2 2004/01/02 13:09:20 liquidx Exp $

DESCRIPTION="Synchronize Windows CE devices with computers running GNU/Linux, like MS ActiveSync."
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-libs/check-0.8.2
	>=dev-libs/libmimedir-0.3
	>=app-pda/synce-libsynce-0.3
	>=app-pda/synce-librapi2-0.8"

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR="${D%/}" install || die
}
