# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/awesome/awesome-2.1.ebuild,v 1.2 2008/01/25 18:14:01 matsuu Exp $

inherit toolchain-funcs eutils

DESCRIPTION="awesome is a window manager initialy based on a dwm code rewriting"
HOMEPAGE="http://awesome.naquadah.org/"
SRC_URI="http://awesome.naquadah.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/confuse-2.6
	x11-libs/cairo
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXft
	x11-libs/libXrandr
	x11-libs/libXinerama"

DEPEND="${RDEPEND}
	app-text/asciidoc
	app-text/xmlto
	app-doc/doxygen
	dev-util/pkgconfig
	x11-proto/xineramaproto"

src_compile() {
	econf --docdir="/usr/share/doc/${PF}" || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	exeinto /etc/X11/Sessions
	newexe "${FILESDIR}"/${PN}-session ${PN}

	insinto /usr/share/xsessions
	doins "${FILESDIR}"/${PN}.desktop

	insinto /usr/share/awesome/icons/layouts
	doins icons/layouts/*

	prepalldocs
}
