# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/lsdvd/lsdvd-0.10.ebuild,v 1.2 2004/03/02 15:26:58 augustus Exp $

DESCRIPTION="Utility for getting info out of DVDs"
HOMEPAGE="http://acidrip.thirtythreeandathird.net"
SRC_URI="mirror://sourceforge/acidrip/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86 ~amd64"
IUSE=""

# Build-time dependencies, such as
#    ssl? ( >=openssl-0.9.6b )
#    >=perl-5.6.1-r1
# It is advisable to use the >= syntax show above, to reflect what you
# had installed on your system when you tested the package.  Then
# other users hopefully won't be caught without the right version of
# a dependency.
DEPEND="=libdvdread-0.9*"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS NEWS README
}
