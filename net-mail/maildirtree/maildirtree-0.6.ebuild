# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/maildirtree/maildirtree-0.6.ebuild,v 1.1 2004/11/17 21:23:29 ticho Exp $

DESCRIPTION="A utility that prints trees of Courier-style Maildirs."
HOMEPAGE="http://triplehelix.org/~joshk/${PN}"
SRC_URI="http://triplehelix.org/~joshk/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_install() {
	make DESTDIR=${D} install
	dodoc COPYING ChangeLog INSTALL README TODO
}
