# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/unionfs-fuse/unionfs-fuse-0.23.ebuild,v 1.2 2010/01/17 20:23:12 a3li Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Self-syncing tree-merging file system based on FUSE"

HOMEPAGE="http://podgorny.cz/moin/UnionFsFuse"
SRC_URI="http://podgorny.cz/unionfs-fuse/releases/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-fs/fuse"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
}

src_install() {
	dodir /usr/sbin /usr/share/man/man8/ || die "dodir failed"
	emake DESTDIR="${D}/usr" install || die "emake install failed"
}
