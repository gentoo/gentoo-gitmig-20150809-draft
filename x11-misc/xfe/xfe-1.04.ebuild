# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xfe/xfe-1.04.ebuild,v 1.6 2007/11/21 18:21:11 nixnut Exp $

inherit eutils

DESCRIPTION="MS-Explorer-like minimalist file manager for X"
HOMEPAGE="http://roland65.free.fr/xfe"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="debug nls"

DEPEND="=x11-libs/fox-1.6*
	nls? ( sys-devel/gettext )"

pkg_setup() {
	local use_check="Re-emerge =x11-libs/fox-1.6* with USE truetype."

	if ! built_with_use "=x11-libs/fox-1.6*" truetype; then
		eerror "${use_check}"
		die "${use_check}"
	fi

	if ! built_with_use "=x11-libs/fox-1.6*" png; then
		ewarn "Re-emerge =x11-libs/fox-1.6* with USE png for image support."
		epause
	fi
}

src_compile() {
	econf $(use_enable nls) $(use_enable debug)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS BUGS ChangeLog README TODO
	make_desktop_entry xfe "X File Explorer" xfe "System;FileTools;FileManager"
	make_desktop_entry xfi "X File Image" xfi "System;FileTools"
	make_desktop_entry xfp "X File Package" xfp "System;FileTools"
	make_desktop_entry xfv "X File View" xfv "System;FileTools"
	make_desktop_entry xfw "X File Write" xfw "System;FileTools"
}
