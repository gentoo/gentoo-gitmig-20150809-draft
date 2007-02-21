# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmbups/gkrellmbups-2.0.2-r1.ebuild,v 1.1 2007/02/21 16:34:26 lack Exp $

inherit multilib

IUSE="nut"
DESCRIPTION="GKrellM2 Belkin UPS monitor Plugin"
SRC_URI="http://www.starforge.co.uk/gkrellm/files/${P}.tar.gz"
HOMEPAGE="http://www.starforge.co.uk/gkrellm/gkrellmbups.shtml"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~sparc x86"

RDEPEND=">=app-admin/gkrellm-2
	nut? ( sys-power/nut )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:/usr/include/gkrell:/usr/include/gkrellm2:g' configure
}

src_compile() {
	econf `use_enable nut` || die "configure failed"
	emake || die
}

src_install () {
	insinto /usr/$(get_libdir)/gkrellm2/plugins
	newins src/gkrellmbups gkrellmbups.so
	dodoc COPYING INSTALL README TODO
}
