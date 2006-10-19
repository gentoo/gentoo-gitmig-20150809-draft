# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/cpulimit/cpulimit-1.1.ebuild,v 1.1 2006/10/19 01:34:24 tcort Exp $

inherit eutils

DESCRIPTION="limits the CPU usage of a process"
HOMEPAGE="http://marlon80.interfree.it/cpulimit/"
SRC_URI="http://marlon80.interfree.it/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_install() {
	dosbin cpulimit
	doman "${FILESDIR}/cpulimit.8"
}
