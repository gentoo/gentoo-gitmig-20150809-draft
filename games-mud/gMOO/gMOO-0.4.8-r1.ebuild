# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/gMOO/gMOO-0.4.8-r1.ebuild,v 1.13 2007/07/21 19:32:18 nyhm Exp $

inherit eutils

DESCRIPTION="GTK+ Based MOO client"
HOMEPAGE="http://www.gmoo.net/gmoo/"
SRC_URI="http://www.nowmoo.demon.nl/packages/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86 ppc"
IUSE="nls tcl"

RDEPEND="x11-libs/libXi
	=x11-libs/gtk+-1.2*
	nls? ( virtual/libintl )
	tcl? ( dev-lang/tcl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	use nls && epatch "${FILESDIR}"/gMOO.patch
	sed -i \
		-e "s/-ltcl8.0/-ltcl/" configure \
		|| die "sed configure failed"
}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable tcl) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README VERSION NEWS TODO ChangeLog || die "dodoc failed"
}
