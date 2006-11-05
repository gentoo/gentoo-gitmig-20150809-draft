# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/gMOO/gMOO-0.4.8-r1.ebuild,v 1.12 2006/11/05 02:16:27 nyhm Exp $

inherit eutils

DESCRIPTION="GTK+ Based MOO client"
HOMEPAGE="http://www.nowmoo.demon.nl/"
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
