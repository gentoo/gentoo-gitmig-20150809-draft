# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/unix2tcp/unix2tcp-0.8.2.ebuild,v 1.7 2005/03/13 03:36:04 vapier Exp $

inherit eutils

DESCRIPTION="a connection forwarder that converts Unix sockets into TCP sockets"
HOMEPAGE="http://dizzy.roedu.net/unix2tcp/"
SRC_URI="http://dizzy.roedu.net/unix2tcp/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 arm hppa ia64 ~ppc s390 x86"
IUSE=""

DEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog README
}
