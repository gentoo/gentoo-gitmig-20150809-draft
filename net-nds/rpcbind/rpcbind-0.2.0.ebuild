# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/rpcbind/rpcbind-0.2.0.ebuild,v 1.6 2011/03/18 08:47:06 vapier Exp $

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://git.infradead.org/~steved/rpcbind.git"
	inherit autotools git
	SRC_URI=""
	#KEYWORDS=""
else
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
	KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh ~sparc ~x86"
fi

DESCRIPTION="portmap replacement which supports RPC over various protocols"
HOMEPAGE="http://sourceforge.net/projects/rpcbind/"

LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="net-libs/libtirpc"
RDEPEND=${DEPEND}

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
