# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/lfhex/lfhex-0.3.7-r1.ebuild,v 1.2 2004/08/01 20:53:56 dholm Exp $

inherit eutils

DESCRIPTION="A fast, efficient hex-editor with support for large files and comparing binary files"
HOMEPAGE="http://freshmeat.net/projects/lfhex"
SRC_URI="http://home.earthlink.net/~eyekode/data/${P}.tar.gz"
LICENSE="QPL-1.0"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE=""

RDEPEND=">=x11-libs/qt-3
	virtual/x11"

DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison
	sys-apps/grep
	sys-apps/net-tools"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/lfhex-gcc3-inline-fix.patch
}

src_compile() {
	econf || die
	emake || die "emake failed"
}

src_install() {
	dobin bin/lfhex
	dodoc LICENSE.QPL
	dodoc README
	dodoc README.install
}
