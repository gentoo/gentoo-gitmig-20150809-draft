# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsimpsons/xsimpsons-0.1.ebuild,v 1.8 2006/01/21 18:42:10 nelchael Exp $

DESCRIPTION="The Simpsons walking along the tops of your windows."
HOMEPAGE="http://netzverschmutzer.net/~sbeyer/programming/projects/?dir=extensions#xpenguins"
SRC_URI="http://netzverschmutzer.net/~sbeyer/programming/projects/extensions/xpenguins/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXt
		11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xproto
		x11-proto/xextproto )
	virtual/x11 )"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin xsimpsons || die "dobin failed"
}
