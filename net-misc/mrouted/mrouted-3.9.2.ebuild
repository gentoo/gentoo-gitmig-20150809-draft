# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mrouted/mrouted-3.9.2.ebuild,v 1.1 2010/09/18 02:22:42 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="IP multicast routing daemon"
HOMEPAGE="http://troglobit.com/mrouted.shtml"
SRC_URI="ftp://ftp.vmlinux.org/pub/People/jocke/${PN}/${P}.tar.bz2"
LICENSE="Stanford"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="|| ( dev-util/yacc sys-devel/bison )"
RDEPEND=""

src_prepare() {
cp -av Makefile{,.orig}
	epatch "${FILESDIR}"/${P}-flags.patch
}

src_compile() {
	emake CC=$(tc-getCC) || die
}

src_install() {
	dobin mrouted || die
	dosbin mtrace mrinfo map-mbone || die
	doman mrouted.8 mtrace.8 mrinfo.8 map-mbone.8 || die

	insinto /etc
	doins mrouted.conf || die
	newinitd "${FILESDIR}"/mrouted.rc mrouted || die
}
