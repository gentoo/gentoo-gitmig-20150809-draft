# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/log-toolkit/log-toolkit-0.9.6.ebuild,v 1.3 2004/06/25 00:58:01 agriffis Exp $

DESCRIPTION="set of tools to manipulate and maintain webserver logfiles"
HOMEPAGE="http://sourceforge.net/projects/log-toolkit/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc
	net-www/apache"

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
}
