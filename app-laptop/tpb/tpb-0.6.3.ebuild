# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/tpb/tpb-0.6.3.ebuild,v 1.2 2004/10/17 12:32:22 brix Exp $

inherit eutils

DESCRIPTION="IBM ThinkPad buttons utility"
HOMEPAGE="http://savannah.nongnu.org/projects/tpb/"
SRC_URI="http://savannah.nongnu.org/download/tpb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls xosd X"

DEPEND="X? ( virtual/x11 )
		xosd? ( >=x11-libs/xosd-2.2.0 )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-configure-fix.diff
}

src_compile() {
	econf `use_enable nls` `use_with X x` `use_enable xosd` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README ChangeLog CREDITS doc/{nvram.txt,callback_example.sh}
}

pkg_postinst() {
	einfo ""
	einfo "${P} requires /dev/nvram support (CONFIG_NVRAM) to be enabled"
	einfo "in the kernel to function."
	einfo ""
}
