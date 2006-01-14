# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xkbd/xkbd-0.8.12.ebuild,v 1.11 2006/01/14 12:14:35 nelchael Exp $

DESCRIPTION="Xkbd - onscreen soft keyboard for X11"
HOMEPAGE="http://handhelds.org/~mallum/xkbd/"
SRC_URI="http://handhelds.org/~mallum/xkbd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~ppc x86"

IUSE="doc debug"

RDEPEND="|| ( ( x11-libs/libXrender
			x11-libs/libX11
			virtual/xft
			x11-libs/libXtst
			x11-libs/libXpm
		)
		virtual/x11
	)
	media-libs/freetype
	dev-libs/expat
	sys-libs/zlib
	doc? ( app-text/docbook-sgml-utils )"

DEPEND="${RDEPEND}
	|| ( ( x11-proto/xproto
			x11-proto/xextproto
		)
		virtual/x11
	)"

src_compile() {
	econf\
	`use_enable debug` || die "econf failed"

	emake || die

	if use doc; then
		docbook2html README
	fi
}

src_install() {
	einstall || die
	dodoc AUTHORS NEWS README

	if use doc; then
		insinto /usr/share/doc/${PF}/html
		doins *.html
	fi
}
