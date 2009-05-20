# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ncmpc/ncmpc-0.11.1-r2.ebuild,v 1.9 2009/05/20 16:13:09 ssuominen Exp $

inherit eutils autotools

DESCRIPTION="A ncurses client for the Music Player Daemon (MPD)"
HOMEPAGE="http://www.musicpd.org/?page=ncmpc"
SRC_URI="http://mercury.chem.pitt.edu/~shank/${P}.tar.gz mirror://sourceforge/musicpd/${P}.tar.gz"
LICENSE="GPL-2"
IUSE="clock-screen mouse search-screen key-screen raw-mode nls debug"

SLOT="0"
KEYWORDS="ppc"

RDEPEND="sys-libs/ncurses
	dev-libs/popt
	>=dev-libs/glib-2.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	use search-screen && elog "Please note that the search-screen is experimental"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"
	if built_with_use sys-libs/ncurses unicode ; then
		epatch "${FILESDIR}"/${PV}-widechars.patch
		eautoreconf
	fi
}

src_compile() {
	econf $(use_enable clock-screen) \
		  $(use_enable debug) \
		  $(use_enable mouse) \
		  $(use_enable key-screen) \
		  $(use_enable search-screen) \
		  $(use_with nls) \
		  $(use_with raw-mode)

	emake || die "make failed"
}

src_install() {
	make install DESTDIR=${D} docdir=/usr/share/doc/${PF} \
		|| die "install failed"

	prepalldocs
}
