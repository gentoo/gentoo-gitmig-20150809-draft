# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ssrc/ssrc-1.30.ebuild,v 1.4 2009/06/25 18:01:17 armin76 Exp $

EAPI=2
inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="A fast and high quality sampling rate converter"
HOMEPAGE="http://shibatch.sourceforge.net"
SRC_URI="http://shibatch.sf.net/download/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="app-arch/unzip"

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
}

src_compile() {
	use sparc && append-cflags -DBIGENDIAN
	tc-export CC
	emake || die "emake failed"
}

src_install() {
	dobin ssrc{,_hp} || die "dobin failed"
	dodoc {history,ssrc}.txt
}
