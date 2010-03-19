# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/tnef/tnef-1.3.4.ebuild,v 1.9 2010/03/19 17:01:06 jer Exp $

DESCRIPTION="Decodes MS-TNEF MIME attachments"
SRC_URI="mirror://sourceforge/tnef/${P}.tar.gz"
HOMEPAGE="http://world.std.com/~damned/software.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 hppa ppc sparc x86"
IUSE=""

DEPEND=""

src_install() {
	make DESTDIR="${D}" install || die
	rm -rf "${D}"/usr/man
	dodoc AUTHORS BUGS ChangeLog COPYING NEWS README TODO
	doman doc/tnef.1
}
