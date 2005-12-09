# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/fish/fish-1.18.1.ebuild,v 1.2 2005/12/09 15:29:02 josejx Exp $

DESCRIPTION="fish is the Friendly Interactive SHell"
HOMEPAGE="http://roo.no-ip.org/fish/"
SRC_URI="http://roo.no-ip.org/fish/files/${PV}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RDEPEND="sys-libs/ncurses
	sys-devel/bc
	|| ( (
			x11-libs/libSM
			x11-libs/libXext
		)
		virtual/x11
	)"
DEPEND="${RDEPEND}
	app-doc/doxygen"

src_compile() {
	econf docdir=/usr/share/doc/${PF} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install
}
