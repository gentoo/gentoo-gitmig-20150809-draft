# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/hardlink-fedora/hardlink-fedora-20120519.ebuild,v 1.1 2012/05/19 12:21:57 ssuominen Exp $

EAPI=4
inherit toolchain-funcs

DESCRIPTION="Create a tree of hardlinks"
HOMEPAGE="http://pkgs.fedoraproject.org/gitweb/?p=hardlink.git"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="!app-arch/hardlink"
DEPEND="${RDEPEND}"

src_compile() {
	$(tc-getCC) ${LDFLAGS} ${CFLAGS} hardlink.c -o hardlink || die
}

src_install() {
	dobin hardlink
	doman hardlink.1
}
