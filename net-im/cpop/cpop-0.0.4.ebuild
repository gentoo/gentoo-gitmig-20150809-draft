# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/cpop/cpop-0.0.4.ebuild,v 1.1 2004/04/27 15:17:49 rizzo Exp $

DESCRIPTION="GTK+ network popup message client. Compatable with the jpop protocol."
HOMEPAGE="http://www.draxil.uklinux.net/hip/index.pl?page=cpop"
SRC_URI="http://www.draxil.uklinux.net/hip/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.2.0
		>=dev-libs/glib-2.0.0"

src_install() {
	einstall || die
}
