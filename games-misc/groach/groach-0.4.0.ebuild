# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/groach/groach-0.4.0.ebuild,v 1.5 2005/06/15 18:43:01 wolf31o2 Exp $

DESCRIPTION="all-time best the xroach returns to GNOME"
HOMEPAGE="http://home.catv.ne.jp/pp/ginoue/software/groach/"
SRC_URI="http://home.catv.ne.jp/pp/ginoue/software/groach/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls"

DEPEND="=x11-libs/gtk+-1.2*
	gnome-base/gnome-core
	>=gnome-base/gnome-libs-1.0.0
	nls? ( sys-devel/gettext )"

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	einstall || die
	dodoc ABOUT-NLS AUTHORS ChangeLog NEWS README TODO || die
}
