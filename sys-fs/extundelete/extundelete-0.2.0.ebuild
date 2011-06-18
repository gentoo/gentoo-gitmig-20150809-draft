# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/extundelete/extundelete-0.2.0.ebuild,v 1.2 2011/06/18 20:22:40 hwoarang Exp $

EAPI=3

_E2FS=1.41.11

DESCRIPTION="A utility to undelete files from an ext3 or ext4 partition"
HOMEPAGE="http://extundelete.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=">=sys-fs/e2fsprogs-${_E2FS}
	>=sys-libs/e2fsprogs-libs-${_E2FS}"

src_configure() {
	econf \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README
}
