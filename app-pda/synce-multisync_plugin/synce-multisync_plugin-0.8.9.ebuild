# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-multisync_plugin/synce-multisync_plugin-0.8.9.ebuild,v 1.1 2004/03/26 12:34:10 tad Exp $

DESCRIPTION="Multisync plugin to synchronize Windows CE devices with computers running GNU/Linux, like MS ActiveSync."
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc
	>=dev-libs/check-0.8.2
	>=app-pda/synce-libsynce-0.8.9
	>=app-pda/synce-rra-0.8.9
	>=app-pda/multisync-0.81"

src_compile() {
	econf --with-multisync-include=/usr/include/multisync --with-rra-include=/usr/include
	emake || die
}

src_install() {
	make DESTDIR="${D%/}" install || die
}
