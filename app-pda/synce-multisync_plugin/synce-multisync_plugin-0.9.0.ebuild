# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-multisync_plugin/synce-multisync_plugin-0.9.0.ebuild,v 1.4 2006/03/16 18:18:09 sekretarz Exp $

DESCRIPTION="Multisync plugin to synchronize Windows CE devices with Linux"
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-libs/check-0.8.2
	>=app-pda/synce-libsynce-0.9.0
	>=app-pda/synce-rra-0.9.0
	>=app-pda/multisync-0.81"

src_compile() {
	econf \
		--with-multisync-include=/usr/include/multisync  \
		--with-rra-include=/usr/include \
		|| die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR="${D%/}" install || die
}
