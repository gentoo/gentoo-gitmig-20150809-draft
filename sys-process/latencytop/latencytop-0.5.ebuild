# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/latencytop/latencytop-0.5.ebuild,v 1.1 2009/12/18 15:58:29 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="tool for identifying where in the system latency is happening"
HOMEPAGE="http://www.latencytop.org/"
SRC_URI="http://www.latencytop.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk unicode"

RDEPEND="=dev-libs/glib-2*
	gtk? ( =x11-libs/gtk+-2* )
	sys-libs/ncurses"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-*.patch
}

src_compile() {
	tc-export CC PKG_CONFIG
	emake HAS_GTK_GUI=$(use gtk && echo 1) || die
}

src_install() {
	emake install DESTDIR="${D}" || die
}
