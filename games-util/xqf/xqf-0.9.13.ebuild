# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/xqf/xqf-0.9.13.ebuild,v 1.1 2003/11/29 20:44:49 vapier Exp $

inherit games

DESCRIPTION="A server browser for many FPS games (frontend for qstat)"
HOMEPAGE="http://www.linuxgames.com/xqf/"
SRC_URI="mirror://sourceforge/xqf/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="nls"

DEPEND=">=games-util/qstat-25
	=x11-libs/gtk+-1.2*
	sys-devel/libtool
	app-arch/bzip2
	media-libs/gdk-pixbuf"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	egamesconf \
		`use_enable nls` \
		--enable-bzip2 \
		|| die
	emake || die "emake failed"
}

src_install() {
	egamesinstall || die
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
	prepgamesdirs
}
