# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/madman/madman-0.91.1.ebuild,v 1.5 2004/03/31 18:28:45 eradicator Exp $

DESCRIPTION="MP3 organizer/ID3 tag-editor extrodinaire"
HOMEPAGE="http://madman.sf.net"
SRC_URI="mirror://sourceforge/madman/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=x11-libs/qt-3.1.0-r3
	>=media-libs/libvorbis-1.0
	>=media-sound/xmms-1.2.7-r20
	>=media-libs/id3lib-3.8.3"

src_compile() {
	addwrite "${QTDIR}/etc/settings"
	econf --prefix=/usr --libdir=/usr/lib
	emake
}

src_install() {
	einstall libdir=${D}/usr/lib || die
}
