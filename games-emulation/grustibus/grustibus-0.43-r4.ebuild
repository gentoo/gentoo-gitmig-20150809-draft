# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/grustibus/grustibus-0.43-r4.ebuild,v 1.9 2006/11/03 22:29:59 nyhm Exp $

inherit eutils

DESCRIPTION="A GNOME-based front-end for the M.A.M.E. video game emulator"
HOMEPAGE="http://grustibus.sourceforge.net/"
SRC_URI="mirror://sourceforge/grustibus/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls"

RDEPEND=">=games-emulation/xmame-0.80.1
	>=media-libs/gdk-pixbuf-0.17.0
	>=gnome-base/gnome-libs-1.4.1.2
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-crash.patch"
	epatch "${FILESDIR}/${PV}-filename.patch" # bug #57004
	epatch "${FILESDIR}"/${P}-sandbox.patch
}

src_compile() {
	export CPPFLAGS=$(gdk-pixbuf-config --cflags)
	econf $(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README ChangeLog TODO NEWS
}
