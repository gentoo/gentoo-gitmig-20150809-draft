# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/awesome/awesome-2.3.6.ebuild,v 1.2 2011/03/30 11:13:11 angelos Exp $

EAPI="2"
inherit toolchain-funcs eutils

DESCRIPTION="A dynamic floating and tiling window manager"
HOMEPAGE="http://awesome.naquadah.org/"
SRC_URI="http://awesome.naquadah.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="doc gtk"

RDEPEND=">=dev-libs/confuse-2.6
	x11-libs/cairo[X]
	x11-libs/pango
	x11-libs/libX11
	x11-libs/libXrandr
	x11-libs/libXinerama
	gtk? ( x11-libs/gtk+:2 )
	!gtk? ( media-libs/imlib2 )"

DEPEND="${RDEPEND}
	app-text/asciidoc
	app-text/xmlto
	dev-util/pkgconfig
	x11-proto/xineramaproto
	doc? (
		app-doc/doxygen
		media-gfx/graphviz
	)"

src_configure() {
	econf \
		$(use_with gtk) \
		--docdir="/usr/share/doc/${PF}"
}

src_compile() {
	default

	if use doc; then
		emake doc || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	exeinto /etc/X11/Sessions
	newexe "${FILESDIR}"/${PN}-session ${PN}

	insinto /usr/share/xsessions
	doins "${FILESDIR}"/${PN}.desktop

	insinto /usr/share/awesome/icons
	doins -r icons/*

	if use doc; then
		dohtml doc/html/*
	fi

	prepalldocs
}
