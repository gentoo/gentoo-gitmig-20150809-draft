# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xbattbar/xbattbar-1.4.2.ebuild,v 1.9 2006/10/11 12:10:36 nelchael Exp $

IUSE=""

DESCRIPTION="Advanced Power Management battery status display for X"
HOMEPAGE="http://iplab.aist-nara.ac.jp/member/suguru/xbattbar.html"
SRC_URI="http://iplab.aist-nara.ac.jp/member/suguru/${P/-/_}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-misc/gccmakedep
		x11-misc/imake
		x11-libs/libX11 )
	virtual/x11 )"

src_compile() {

	xmkmf -a || die "xmkmf failed"
	emake || die
}

src_install() {

	dobin xbattbar

	newman xbattbar.man xbattbar.1
	dodoc README copyright
}
