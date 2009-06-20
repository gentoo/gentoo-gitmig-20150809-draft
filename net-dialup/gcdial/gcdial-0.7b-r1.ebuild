# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gcdial/gcdial-0.7b-r1.ebuild,v 1.1 2009/06/20 10:15:08 mrness Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A simple GTK+ client for DWUN"
HOMEPAGE="http://dwun.sourceforge.net/"
SRC_URI="mirror://sourceforge/dwun/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*"
RDEPEND="${DEPEND}
	net-dialup/dwun"

src_prepare() {
	epatch "${FILESDIR}"/${P}-getline.patch
}

src_install() {
	einstall || die "install failed."
	dodoc AUTHORS ChangeLog README TODO
}
