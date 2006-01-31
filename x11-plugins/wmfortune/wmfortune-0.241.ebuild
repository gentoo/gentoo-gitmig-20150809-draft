# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmfortune/wmfortune-0.241.ebuild,v 1.10 2006/01/31 21:24:02 nelchael Exp $

IUSE=""
DESCRIPTION="dock-app that shows fortune messages"
HOMEPAGE="http://www.dockapps.com/file.php/id/90"
SRC_URI="http://www.dockapps.com/download.php/id/128/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="x86 amd64 ppc ~sparc"

RDEPEND="games-misc/fortune-mod
	|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xproto
		x11-proto/xextproto )
	virtual/x11 )"

src_compile() {
	emake OPTIMIZE="${CFLAGS}" || die
}

src_install()
{
	dobin wmfortune
	dodoc CHANGES README TODO
}
