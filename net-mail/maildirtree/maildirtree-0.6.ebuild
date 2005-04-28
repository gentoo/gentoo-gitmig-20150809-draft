# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/maildirtree/maildirtree-0.6.ebuild,v 1.3 2005/04/28 20:51:44 slarti Exp $

DESCRIPTION="A utility that prints trees of Courier-style Maildirs."
HOMEPAGE="http://triplehelix.org/~joshk/maildirtree"
SRC_URI="http://triplehelix.org/~joshk/maildirtree/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

src_install() {
	make DESTDIR=${D} install
	dodoc COPYING ChangeLog INSTALL README TODO
}
