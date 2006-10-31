# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ntfs3g/ntfs3g-0.20061031.ebuild,v 1.1 2006/10/31 03:42:07 chutzpah Exp $

MY_PN="${PN/3g/-3g}"
MY_PV="${PV}-BETA"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Open source read-write NTFS driver that runs under FUSE"
HOMEPAGE="http://www.ntfs-3g.org"
SRC_URI="http://www.ntfs-3g.org/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=sys-fs/fuse-2.5.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# default makefile calls ldconfig
	sed -ie '/ldconfig$/ d' src/Makefile.*
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog CREDITS NEWS README
}
