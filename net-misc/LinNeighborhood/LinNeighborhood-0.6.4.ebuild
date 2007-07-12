# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/LinNeighborhood/LinNeighborhood-0.6.4.ebuild,v 1.17 2007/07/12 02:52:15 mr_bones_ Exp $

IUSE="nls"

DESCRIPTION="LinNeighborhood is a easy to use frontend to samba/NETBios."
SRC_URI="http://www.bnro.de/~schmidjo/download/${P}.tar.gz"
HOMEPAGE="http://www.bnro.de/~schmidjo/index.html"
KEYWORDS="x86 sparc "
LICENSE="GPL-2"
SLOT="0"

DEPEND="	=x11-libs/gtk+-1.2* net-fs/samba
		nls? ( sys-devel/gettext ) "

src_compile() {

	local myopts

	use nls || myopts="--disable-nls"

	./configure --prefix=/usr \
		--host=${CHOST} \
		--enable-ipv6 \
		${myopts} || die

	emake || die
}

src_install() {

	make prefix=${D}/usr install || die

	dodoc README AUTHORS TODO THANKS BUGS NEW COPYING ChangeLog
}
