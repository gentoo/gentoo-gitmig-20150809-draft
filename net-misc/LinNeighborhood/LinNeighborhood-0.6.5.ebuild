# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/LinNeighborhood/LinNeighborhood-0.6.5.ebuild,v 1.1 2002/07/21 18:29:01 blizzy Exp $ 

S=${WORKDIR}/${P}
DESCRIPTION="LinNeighborhood is a easy to use frontend to samba/NETBios."
SRC_URI="http://www.bnro.de/~schmidjo/download/${P}.tar.gz"
HOMEPAGE="http://www.bnro.de/~schmidjo/index.html"
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="=x11-libs/gtk+-1.2* net-fs/samba
	nls? ( sys-devel/gettext )"
RDEPEND="${DEPEND}"

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
