# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/netrik/netrik-1.15.6.ebuild,v 1.4 2010/01/26 11:46:22 cla Exp $

DESCRIPTION="A text based web browser with no ssl support."
HOMEPAGE="http://netrik.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="amd64 ~sparc x86"
IUSE="nls"

DEPEND=">=sys-libs/ncurses-5.1
	>=sys-libs/zlib-1.1.3
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -r -e /^CFLAGS/s:@CFLAGS@:"${CFLAGS}": -i Makefile.in
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
