# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/mtpfs/mtpfs-0.9.ebuild,v 1.1 2011/06/30 10:16:21 xarthisius Exp $

EAPI=4

inherit base

DESCRIPTION="A FUSE filesystem providing access to MTP devices"
HOMEPAGE="http://www.adebenham.com/mtpfs/"
SRC_URI="http://www.adebenham.com/debian/${P/-/_}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="dev-libs/glib:2
	media-libs/libid3tag
	media-libs/libmad
	media-libs/libmtp
	sys-fs/fuse"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}.orig

PATCHES=( "${FILESDIR}"/${P}-overflow.patch )
DOCS=(AUTHORS NEWS README)

src_configure() {
	econf $(use_enable debug)
}

pkg_postinst() {
	einfo "To mount your MTP device, issue:"
	einfo "    /usr/bin/mtpfs <mountpoint>"
	echo
	einfo "To unmount your MTP device, issue:"
	einfo "    /usr/bin/fusermount -u <mountpoint>"

	if use debug; then
		echo
		einfo "You have enabled debugging output."
		einfo "Please make sure you run mtpfs with the -d flag."
	fi
}
