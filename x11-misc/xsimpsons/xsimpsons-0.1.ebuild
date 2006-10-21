# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsimpsons/xsimpsons-0.1.ebuild,v 1.10 2006/10/21 22:05:25 omp Exp $

DESCRIPTION="The Simpsons walking along the tops of your windows."
HOMEPAGE="http://netzverschmutzer.net/~sbeyer/programming/projects/?dir=extensions#xpenguins"
SRC_URI="http://netzverschmutzer.net/~sbeyer/programming/projects/extensions/xpenguins/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXt
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin xsimpsons || die "dobin failed"
}
