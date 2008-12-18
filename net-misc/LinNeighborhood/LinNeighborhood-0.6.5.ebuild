# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/LinNeighborhood/LinNeighborhood-0.6.5.ebuild,v 1.17 2008/12/18 12:23:21 flameeyes Exp $

inherit eutils

IUSE="nls"

DESCRIPTION="LinNeighborhood is a easy to use frontend to samba/NETBios."
SRC_URI="http://www.bnro.de/~schmidjo/download/${P}.tar.gz"
HOMEPAGE="http://www.bnro.de/~schmidjo/index.html"
KEYWORDS="x86 sparc ppc amd64"
LICENSE="GPL-2"
SLOT="0"

DEPEND="=x11-libs/gtk+-1.2* net-fs/samba
	nls? ( sys-devel/gettext )"

src_compile() {
	local myopts

	epatch ${FILESDIR}/linneighborhood-0.6.5-samba301.patch
	use nls || myopts="--disable-nls"

	./configure --prefix=/usr \
		--host=${CHOST} \
		--enable-ipv6 \
		${myopts} || die

	emake || die
}

src_install() {
	make prefix=${D}/usr install || die

	dodoc README AUTHORS TODO THANKS BUGS NEWS COPYING ChangeLog
}
