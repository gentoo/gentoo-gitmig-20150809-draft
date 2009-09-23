# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-multisync_plugin/synce-multisync_plugin-0.8.2.ebuild,v 1.6 2009/09/23 16:13:59 patrick Exp $

DESCRIPTION="Multisync plugin to synchronize Windows CE devices with computers running GNU/Linux, like MS ActiveSync."
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-libs/check-0.8.2
	>=app-pda/synce-libsynce-0.3
	>=app-pda/multisync-0.80"

src_compile() {
	econf -with-multisync-include=/usr/include/multisync || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR="${D%/}" install || die
}
