# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/groach/groach-0.4.0.ebuild,v 1.1 2003/09/10 18:14:05 vapier Exp $

DESCRIPTION="all-time best the xroach returns to GNOME"
HOMEPAGE="http://home.catv.ne.jp/pp/ginoue/software/groach/"
SRC_URI="http://home.catv.ne.jp/pp/ginoue/software/groach/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls"

DEPEND="=x11-libs/gtk+-1.2*
	>=gnome-base/gnome-libs-1.0.0
	nls? ( sys-devel/gettext )"

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	einstall || die
	dodoc ABOUT-NLS AUTHORS ChangeLog INSTALL NEWS README TODO || die
}
