# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/afio/afio-2.5.1.ebuild,v 1.1 2012/03/11 13:43:30 wschlich Exp $

EAPI=4
inherit eutils

DESCRIPTION="makes cpio-format archives and deals somewhat gracefully with input data corruption."
HOMEPAGE="http://members.chello.nl/k.holtman/afio.html"
SRC_URI="http://members.chello.nl/k.holtman/${P}.tgz"

LICENSE="Artistic LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/Makefile-r1.patch
}

src_install() {
	local i
	dobin afio
	dodoc ANNOUNCE-* HISTORY README SCRIPTS
	for i in 1 2 3 4; do
		docinto script$i
		dodoc script$i/*
	done
	doman afio.1
}
