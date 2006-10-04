# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/lfhex/lfhex-0.3.7.2.ebuild,v 1.2 2006/10/04 15:36:01 wolf31o2 Exp $

inherit eutils

DESCRIPTION="A fast, efficient hex-editor with support for large files and comparing binary files"
HOMEPAGE="http://freshmeat.net/projects/lfhex"
SRC_URI="http://home.earthlink.net/~eyekode/data/${P}.tar.gz"
LICENSE="QPL-1.0"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"

IUSE=""

RDEPEND="=x11-libs/qt-3*
	|| (
	( >=x11-libs/libXt-1.0.0 )
	virtual/x11 )"

DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison
	sys-apps/grep
	sys-apps/net-tools"

src_install() {
	dobin bin/lfhex
	dodoc README
}
