# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-itouch/xmms-itouch-0.1.2.ebuild,v 1.3 2003/07/12 18:40:47 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="XMMS plugin for multimedia keys on Logitech keyboards and others alike"
HOMEPAGE="http://www.saunalahti.fi/~syrjala/xmms-itouch/"
SRC_URI="http://www.saunalahti.fi/~syrjala/xmms-itouch/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="media-sound/xmms"

src_install () {
	make DESTDIR=${D} install || die
}


src_compile() {
	local myconf

	use nls || myconf="${myconf} --disable-nls"

	econf ${myconf}
	emake || die
}

pkg_postinst() {
	einfo "To configure the multimedia keys, run \"xev\" and"
	einfo "press desired keys to get the corresponding keycode."
	einfo "Insert this into the xmms plugin config screen."
	einfo "Multimedia key codes can also be found at"
	einfo "\"http://www.saunalahti.fi/~syrjala/xmms-itouch/\""
	einfo "for some keyboard models - but for complete freedom of choice "
	einfo "xev is your friend :-)"
}
