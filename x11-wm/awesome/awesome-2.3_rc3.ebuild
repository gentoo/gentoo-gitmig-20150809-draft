# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/awesome/awesome-2.3_rc3.ebuild,v 1.1 2008/04/22 16:54:01 matsuu Exp $

inherit toolchain-funcs eutils

MY_P="${P/_/-}"
DESCRIPTION="awesome is a window manager initialy based on a dwm code rewriting"
HOMEPAGE="http://awesome.naquadah.org/"
SRC_URI="http://awesome.naquadah.org/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc gtk"

RDEPEND=">=dev-libs/confuse-2.6
	x11-libs/pango
	x11-libs/libX11
	x11-libs/libXrandr
	x11-libs/libXinerama
	gtk? ( x11-libs/gtk+ )
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

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf \
		$(use_with gtk) \
		--docdir="/usr/share/doc/${PF}" || die
	emake || die

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
