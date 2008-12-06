# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/rpcbind/rpcbind-0.1.5.1.ebuild,v 1.1 2008/12/06 11:29:10 ssuominen Exp $

inherit versionator

MY_P=${PN}-$(replace_version_separator 3 '-')

DESCRIPTION="portmap replacement which supports RPC over various protocols"
HOMEPAGE="http://nfsv4.bullopensource.org/doc/tirpc_rpcbind.php"
SRC_URI="http://nfsv4.bullopensource.org/tarballs/rpcbind/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/libtirpc"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# fix busted timestamps
	find . -type f -print0 | xargs -0 touch -r .
}

src_compile() {
	econf --bindir=/sbin || die "econf failed."
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	doman man/rpc{bind,info}.8
	dodoc AUTHORS ChangeLog NEWS README
	newinitd "${FILESDIR}"/rpcbind.initd rpcbind || die "newinitd failed."
	newconfd "${FILESDIR}"/rpcbind.confd rpcbind || die "newconfd failed."
}
