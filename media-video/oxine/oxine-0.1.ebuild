# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/oxine/oxine-0.1.ebuild,v 1.8 2006/02/15 16:05:42 flameeyes Exp $

DESCRIPTION="OSD frontend for xine"
HOMEPAGE="http://oxine.sourceforge.net/"
LICENSE="GPL-2"

RDEPEND=">=media-libs/xine-lib-1_beta8
	lirc? ( app-misc/lirc )
	nls? ( virtual/libintl )
	virtual/x11"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

IUSE="nls lirc"

SLOT="0"
KEYWORDS="x86"

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

	dodoc AUTHORS ChangeLog NEWS README TODO
}
