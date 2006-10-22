# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xwit/xwit-3.4.ebuild,v 1.9 2006/10/22 01:43:00 tcort Exp $

inherit eutils

DESCRIPTION="xwit (x window interface tool) is a hodge-podge collection of simple routines to call some of those X11 functions that don't already have any utility commands built around them."
HOMEPAGE="http://ftp.x.org/contrib/utilities/xwit-3.4.README"
SRC_URI="http://ftp.x.org/contrib/utilities/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-misc/imake
	x11-proto/xproto"

src_compile() {
	epatch "${FILESDIR}/malloc.patch"

	xmkmf || die "xmkmf failed"
	emake || die "Make failed"
}

src_install() {
	dobin xwit
	cp xwit.man xwit.1
	doman xwit.1
}
