# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/obexfs/obexfs-0.6.ebuild,v 1.1 2006/01/03 19:42:11 mrness Exp $

DESCRIPTION="OBEX filesystem"
SRC_URI="http://triq.net/obexftp/beta-testing/${P}.tar.gz"
HOMEPAGE="http://triq.net/obex"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-libs/openobex-1.0.0
	>=app-mobilephone/obexftp-0.18_beta4
	>=sys-fs/fuse-2.4.1-r1"

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog
}
