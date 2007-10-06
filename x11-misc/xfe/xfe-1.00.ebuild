# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xfe/xfe-1.00.ebuild,v 1.3 2007/10/06 18:40:53 dertobi123 Exp $

inherit eutils

DESCRIPTION="MS-Explorer-like minimalist file manager for X"
HOMEPAGE="http://roland65.free.fr/xfe"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~ppc64 sparc x86"
IUSE="debug nls"

DEPEND="=x11-libs/fox-1.6*
	nls? ( sys-devel/gettext )"

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
