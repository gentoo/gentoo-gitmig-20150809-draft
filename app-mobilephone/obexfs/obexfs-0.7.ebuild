# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/obexfs/obexfs-0.7.ebuild,v 1.2 2006/03/04 20:13:11 mrness Exp $

DESCRIPTION="FUSE filesystem interface for ObexFTP"
HOMEPAGE="http://triq.net/obex/"
SRC_URI="http://triq.net/obexftp/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-libs/openobex-1.0.0
	>=net-wireless/bluez-libs-2.19
	>=app-mobilephone/obexftp-0.18
	>=sys-fs/fuse-2.4.1-r1"

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog README
}
