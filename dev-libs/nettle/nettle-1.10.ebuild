# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/nettle/nettle-1.10.ebuild,v 1.5 2004/08/30 19:10:36 kugelfang Exp $

inherit flag-o-matic

DESCRIPTION="cryptographic library that is designed to fit easily in any context"
HOMEPAGE="http://www.lysator.liu.se/~nisse/nettle/"
SRC_URI="http://www.lysator.liu.se/~nisse/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~amd64"
IUSE=""

DEPEND="virtual/libc
	dev-libs/gmp
	!<dev-libs/lsh-1.4.3-r1"

#src_compile() {
	# Not necessary anymore
	# BUG #55238
	# Danny van Dyk <kugelfang@gentoo.org> 2004/08/30
	# use amd64 && append-flags -fPIC
	# econf || die
	# emake || die
#}


src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
