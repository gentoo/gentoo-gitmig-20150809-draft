# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/tlswrap/tlswrap-1.02.ebuild,v 1.2 2007/11/14 03:36:05 robbat2 Exp $

inherit eutils

DESCRIPTION="TLSWRAP is a TLS/SSL FTP wrapper/proxy which allows to use TLS with every FTP client"
HOMEPAGE="http://tlswrap.sunsite.dk"
SRC_URI="http://tlswrap.sunsite.dk/${P}.tar.gz"

LICENSE="tlswrap"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.7"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-quiet-stderr.patch"
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodoc ChangeLog README
	einstall || die "einstall failed"
	newinitd "${FILESDIR}/tlswrap.init" tlswrap
}
