# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsimpsons/xsimpsons-0.1.ebuild,v 1.5 2004/06/22 07:55:59 dholm Exp $

DESCRIPTION="The Simpsons walking along the tops of your windows."
HOMEPAGE="http://netzverschmutzer.net/~sbeyer/programming/projects/?dir=extensions#xpenguins"
SRC_URI="http://netzverschmutzer.net/~sbeyer/programming/projects/extensions/xpenguins/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/x11"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin xsimpsons || die "dobin failed"
}
