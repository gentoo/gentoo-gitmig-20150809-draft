# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-mad/xmms-mad-0.5.6-r1.ebuild,v 1.10 2004/10/07 06:33:25 eradicator Exp $

inherit eutils

DESCRIPTION="A XMMS plugin for MAD"
HOMEPAGE="http://xmms-mad.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmms-mad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc amd64 ppc64"

IUSE=""

DEPEND="media-sound/xmms
	>=media-sound/madplay-0.14.2b-r2
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-mp3header.patch
}

src_install() {
	exeinto `xmms-config --input-plugin-dir`
	doexe src/.libs/libxmmsmad.so || die
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
