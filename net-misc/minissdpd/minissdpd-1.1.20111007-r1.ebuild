# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/minissdpd/minissdpd-1.1.20111007-r1.ebuild,v 1.1 2011/11/08 01:04:03 blueness Exp $

EAPI=4
inherit eutils toolchain-funcs

DESCRIPTION="MiniSSDP Daemon"
SRC_URI="http://miniupnp.free.fr/files/${P}.tar.gz"
HOMEPAGE="http://miniupnp.free.fr/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/net-tools
	|| ( net-misc/miniupnpd net-libs/miniupnpc )"

src_prepare() {
	epatch "${FILESDIR}/${PN}-respect-CFLAGS.patch"
	epatch "${FILESDIR}/${PN}-remove-initd.patch"
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install () {
	einstall PREFIX="${D}"
	newinitd "${FILESDIR}/${PN}.initd-r1" ${PN}
	newconfd "${FILESDIR}/${PN}.confd" ${PN}
	dodoc Changelog.txt README
	doman minissdpd.1
}
