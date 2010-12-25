# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xbindkeys/xbindkeys-1.8.4.ebuild,v 1.6 2010/12/25 19:34:08 fauli Exp $

EAPI="2"

inherit eutils

IUSE="guile tk"

DESCRIPTION="Tool for launching commands on keystrokes"
SRC_URI="http://www.nongnu.org/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/xbindkeys/xbindkeys.html"

LICENSE="GPL-2"
KEYWORDS="amd64 ppc ppc64 ~sparc x86 ~x86-fbsd"
SLOT="0"

RDEPEND="x11-libs/libX11
	guile? ( >=dev-scheme/guile-1.8.4[deprecated] )
	tk? ( dev-lang/tk )"
DEPEND="${RDEPEND}
	x11-proto/xproto"

src_configure() {
	local myconf
	use tk || myconf="${myconf} --disable-tk"
	use guile || myconf="${myconf} --disable-guile"

	econf ${myconf} || die "configure failed"
}

src_compile() {
	emake DESTDIR="${D}" || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" BINDIR=/usr/bin install || die "make install failed"
}
