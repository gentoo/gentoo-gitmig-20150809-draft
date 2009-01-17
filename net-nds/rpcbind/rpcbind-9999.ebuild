# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/rpcbind/rpcbind-9999.ebuild,v 1.1 2009/01/17 17:37:19 vapier Exp $

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://git.infradead.org/~steved/rpcbind.git"
	inherit autotools git
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="portmap replacement which supports RPC over various protocols"
HOMEPAGE="http://sourceforge.net/projects/rpcbind/"

LICENSE="BSD sun-rpc"
SLOT="0"
IUSE=""

DEPEND="net-libs/libtirpc"

src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		git_src_unpack
		eautoreconf
	else
		unpack ${A}
		cd "${S}"
		# fix busted timestamps
		find . -type f -print0 | xargs -0 touch -r .
	fi
}

src_compile() {
	econf --bindir=/sbin || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	doman man/rpc{bind,info}.8
	dodoc AUTHORS ChangeLog NEWS README
	newinitd "${FILESDIR}"/rpcbind.initd rpcbind || die
	newconfd "${FILESDIR}"/rpcbind.confd rpcbind || die
}
