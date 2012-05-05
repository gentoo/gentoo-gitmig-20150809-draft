# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audtty/audtty-0.1.9a-r1.ebuild,v 1.4 2012/05/05 08:11:22 mgorny Exp $

inherit autotools eutils toolchain-funcs

DESCRIPTION="Control Audacious from the command line with a friendly ncurses interface"
HOMEPAGE="http://audtty.alioth.debian.org"
SRC_URI="http://${PN}.alioth.debian.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ppc x86"
IUSE=""

RDEPEND="sys-libs/ncurses
	>=media-sound/audacious-1.5.1"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-cc-and-destdir.patch
	eautoreconf
}

src_compile() {
	tc-export CC
	econf
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc ChangeLog README
}

pkg_postinst() {
	elog "In order to run audtty over ssh or on a seperate TTY locally you need"
	elog "to download and run the following script in a terminal on your desktop:"
	elog ""
	elog "http://${PN}.alioth.debian.org/dbus.sh"
	elog ""
	elog "Once run you will need to add ~/.dbus-session to your ~/.bashrc file."
}
