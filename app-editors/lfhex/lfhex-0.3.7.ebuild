# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/lfhex/lfhex-0.3.7.ebuild,v 1.1 2004/06/14 03:32:32 dragonheart Exp $

DESCRIPTION="A fast, efficient hex-editor with support for large files and comparing binary files"
HOMEPAGE="http://freshmeat.net/projects/lfhex"
SRC_URI="http://home.earthlink.net/~eyekode/data/${P}.tar.gz"
LICENSE="QPL-1.0"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

RDEPEND=">=x11-libs/qt-3
	virtual/x11"

DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison
	sys-apps/grep
	sys-apps/net-tools"

S=${WORKDIR}/${P}

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
