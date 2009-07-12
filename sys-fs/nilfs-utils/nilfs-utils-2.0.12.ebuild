# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/nilfs-utils/nilfs-utils-2.0.12.ebuild,v 1.2 2009/07/12 17:15:06 klausman Exp $

inherit autotools

DESCRIPTION="A New Implementation of a Log-structured File System for Linux"
HOMEPAGE="http://www.nilfs.org/"
SRC_URI="http://www.nilfs.org/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/e2fsprogs-libs"
DEPEND="${DEPEND}
	sys-kernel/linux-headers"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-gentoo.patch"
	eautomake
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README
}
