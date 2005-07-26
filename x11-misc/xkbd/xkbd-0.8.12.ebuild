# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xkbd/xkbd-0.8.12.ebuild,v 1.8 2005/07/26 15:12:21 dholm Exp $

DESCRIPTION="Xkbd - onscreen soft keyboard for X11"
HOMEPAGE="http://handhelds.org/~mallum/xkbd/"
SRC_URI="http://handhelds.org/~mallum/xkbd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~ppc x86"

IUSE="doc debug"

DEPEND="sys-devel/libtool
	virtual/x11
	media-libs/freetype
	virtual/xft
	dev-libs/expat
	sys-libs/zlib
	doc? ( app-text/docbook-sgml-utils )"

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
	dodoc AUTHORS COPYING NEWS README

	if use doc; then
		insinto /usr/share/doc/${PF}/html
		doins *.html
	fi
}
