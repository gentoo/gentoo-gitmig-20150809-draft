# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdtool/cdtool-2.1.8-r1.ebuild,v 1.1 2009/06/19 17:17:51 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="Collection of command-line utilities to control cdrom devices."
HOMEPAGE="http://hinterhof.net/cdtool"
SRC_URI="http://hinterhof.net/cdtool/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=""
DEPEND="!media-sound/cdplay"

src_prepare() {
	epatch "${FILESDIR}"/${P}-glibc-2.10.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CHANGES CREDITS README TODO
}
