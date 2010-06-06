# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/ifuse/ifuse-1.0.0.ebuild,v 1.2 2010/06/06 16:49:41 xarthisius Exp $

EAPI=3

inherit autotools eutils

DESCRIPTION="Mount Apple iPhone/iPod Touch file systems for backup purposes"
HOMEPAGE="http://libimobiledevice.org/"
SRC_URI="http://cloud.github.com/downloads/MattColyer/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=app-pda/libplist-1.3
	>=app-pda/libimobiledevice-1.0.1
	=dev-libs/glib-2*
	sys-fs/fuse"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-asneeded.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS README || die
}

pkg_postinst() {
	ewarn "Only use this filesystem driver to create backups of your data."
	ewarn "The music database is hashed, and attempting to add files will "
	ewarn "cause the iPod/iPhone to consider your database unauthorised."
	ewarn "It will respond by wiping all media files, requiring a restore "
	ewarn "through iTunes. You have been warned."
}
