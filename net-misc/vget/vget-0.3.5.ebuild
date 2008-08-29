# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vget/vget-0.3.5.ebuild,v 1.1 2008/08/29 09:17:38 hanno Exp $

DESCRIPTION="Tool to download videos from the veoh.com service."
HOMEPAGE="http://segfault.gr/projects/lang/en/projects_id/15/secid/28/"
SRC_URI="http://segfault.gr/uploads/projects/releases/vget/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="net-misc/curl
	sys-libs/ncurses
	dev-libs/libxml2"

src_compile() {
	emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc README CHANGELOG || die "dodoc failed"
}
