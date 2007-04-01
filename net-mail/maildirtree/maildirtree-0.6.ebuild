# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/maildirtree/maildirtree-0.6.ebuild,v 1.4 2007/04/01 18:25:05 ticho Exp $

DESCRIPTION="A utility that prints trees of Courier-style Maildirs."
HOMEPAGE="http://triplehelix.org/~joshk/maildirtree"
SRC_URI="http://triplehelix.org/~joshk/maildirtree/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

src_install() {
	make DESTDIR=${D} install
	dodoc ChangeLog INSTALL README TODO
}
