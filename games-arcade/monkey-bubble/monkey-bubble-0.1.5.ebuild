# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/monkey-bubble/monkey-bubble-0.1.5.ebuild,v 1.4 2004/02/20 06:20:00 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="A frozen-bubble clone"
HOMEPAGE="http://monkey-bubble.tuxfamily.org"
SRC_URI="http://monkey-bubble.tuxfamily.org/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=x11-libs/gtk+-2
	>=gnome-base/librsvg-2
	>=gnome-base/libgnomeui-2
	>=media-libs/gstreamer-0.6*"

filter-flags "-fomit-frame-pointer"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/gcc-295.patch
}

src_install() {
	egamesinstall || die
	dodoc AUTHORS ChangeLog || die "dodoc failed"
	prepgamesdirs
}
