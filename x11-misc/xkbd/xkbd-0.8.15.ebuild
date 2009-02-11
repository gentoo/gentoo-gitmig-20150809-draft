# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xkbd/xkbd-0.8.15.ebuild,v 1.1 2009/02/11 21:42:08 nelchael Exp $

inherit eutils

DESCRIPTION="Xkbd - onscreen soft keyboard for X11"
HOMEPAGE="http://handhelds.org/"
SRC_URI="ftp://ftp.yzu.edu.tw/mirror/pub2/ftp.handhelds.org/distributions/familiar/source/v0.8.4-rc1/sources/${P}-CVS.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="doc debug"

RDEPEND="x11-libs/libXrender
	x11-libs/libX11
	x11-libs/libXft
	x11-libs/libXtst
	x11-libs/libXpm
	media-libs/freetype
	dev-libs/expat
	sys-libs/zlib
	doc? ( app-text/docbook-sgml-utils )"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# 2008-03-23 gi1242: Fix handling of -geometry argument
	epatch "${FILESDIR}/xkbd-0.8.15-fix-geometry.patch"

	# 2008-03-23 gi1242: Increase default repeat delay
	epatch "${FILESDIR}/xkbd-0.8.15-increase-delay.patch"
}

src_compile() {
	econf $(use_enable debug) || die "econf failed"
	emake || die "emake failed"

	use doc && docbook2html README
}

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS NEWS README

	if use doc; then
		insinto /usr/share/doc/${PF}/html
		doins *.html
	fi
}
