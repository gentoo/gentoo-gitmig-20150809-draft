# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/jpilot-plucker/jpilot-plucker-0.01.ebuild,v 1.8 2010/07/13 13:58:30 ssuominen Exp $

DESCRIPTION="Plucker plugin for jpilot"
HOMEPAGE="http://www.jlogday.com/code/jpilot-plucker/index.html"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~ppc x86"
IUSE="gtk"

RDEPEND="gtk? ( >=x11-libs/gtk+-2 )
	app-pda/jpilot"
DEPEND="${RDEPEND}
	gtk? ( dev-util/pkgconfig )"

src_compile() {
	econf $(use_enable gtk gtk2)
	emake -j1 || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}
