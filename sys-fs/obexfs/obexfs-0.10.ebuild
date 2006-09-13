# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/obexfs/obexfs-0.10.ebuild,v 1.1 2006/09/13 07:41:23 mrness Exp $

inherit eutils linux-info

DESCRIPTION="FUSE filesystem interface for ObexFTP"
HOMEPAGE="http://triq.net/obex/"
SRC_URI="http://triq.net/obexftp/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=net-wireless/bluez-libs-2.19
	>=app-mobilephone/obexftp-0.19
	>=sys-fs/fuse-2.4.1-r1"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-as-needed.patch"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
}

pkg_postinst() {
	# Check kernel configuration
	local CONFIG_CHECK="~FUSE_FS"
	check_extra_config
}
