# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/oxine/oxine-0.2.ebuild,v 1.7 2004/08/03 11:58:29 dholm Exp $

DESCRIPTION="OSD frontend for xine"
HOMEPAGE="http://oxine.sourceforge.net/"
LICENSE="GPL-2"

DEPEND=">=media-libs/xine-lib-1_beta8
	lirc? ( app-misc/lirc )
	nls? ( sys-devel/gettext )
	virtual/x11"

IUSE="nls lirc"

SLOT="0"
KEYWORDS="x86 ~ppc"

SRC_URI="mirror://sourceforge/oxine/${P}.tar.gz"

src_compile() {

	local myconf
	use nls || myconf="${myconf} --disable-nls"
	use lirc || myconf="${myconf} --disable-lirc"

	econf ${myconf} || die
	emake || die
}

src_install() {

	make DESTDIR=${D} \
		docdir=/usr/share/doc/${PF} \
		docsdir=/usr/share/doc/${PF} \
		install || die

	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README TODO
}
