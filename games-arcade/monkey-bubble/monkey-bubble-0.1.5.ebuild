# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/monkey-bubble/monkey-bubble-0.1.5.ebuild,v 1.1 2003/10/06 04:11:33 mr_bones_ Exp $

inherit games

DESCRIPTION="A frozen-bubble clone"
HOMEPAGE="http://monkey-bubble.tuxfamily.org"
SRC_URI="http://monkey-bubble.tuxfamily.org/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=gtk+-2.0*
	>=librsvg-2*
	>=libgnomeui-2*
	>=gstreamer-0.6*"

filter-flags "-fomit-frame-pointer"

src_install() {
	egamesinstall || die
	dodoc AUTHORS ChangeLog || die "dodoc failed"
	prepgamesdirs
}
