# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-rra/synce-rra-0.9.0.ebuild,v 1.5 2005/01/26 14:03:19 liquidx Exp $

inherit eutils

DESCRIPTION="Synchronize Windows CE devices with computers running GNU/Linux, like MS ActiveSync."
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=dev-libs/check-0.8.2
	>=dev-libs/libmimedir-0.3
	>=app-pda/synce-libsynce-0.9.0
	>=app-pda/synce-librapi2-0.9.0"

src_unpack() {
	unpack ${A}
	cd ${S}/lib
	epatch ${FILESDIR}/${PV}-gcc34.patch
}

src_install() {
	make DESTDIR="${D%/}" install || die
}
