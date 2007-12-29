# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/rpcbind/rpcbind-0.1.4.ebuild,v 1.1 2007/12/29 09:13:54 vapier Exp $

DESCRIPTION="portmap replacement which supports RPC over various protocols"
HOMEPAGE="http://nfsv4.bullopensource.org/doc/tirpc_rpcbind.php"
SRC_URI="http://nfsv4.bullopensource.org/tarballs/rpcbind/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/libtirpc"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# fix busted timestamps
	find . -type f -print0 | xargs -0 touch -r .
}

src_compile() {
	econf --bindir=/sbin || die
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	doman man/rpc{bind,info}.8
	dodoc AUTHORS ChangeLog NEWS README
	newinitd "${FILESDIR}"/rpcbind.initd rpcbind || die
	newconfd "${FILESDIR}"/rpcbind.confd rpcbind || die
}
