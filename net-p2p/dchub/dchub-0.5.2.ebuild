# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dchub/dchub-0.5.2.ebuild,v 1.4 2004/11/06 16:53:04 squinky86 Exp $

IUSE=""

HOMEPAGE="http://brainz.servebeer.com/dctc/#dchub"
DESCRIPTION="dchub (Direct Connect Hub), a linux hub for the p2p 'direct connect'"
SRC_URI="http://brainz.servebeer.com/dctc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

RDEPEND="virtual/libc
	=dev-libs/glib-1*
	dev-lang/perl
	dev-db/edb"

src_install() {
	make DESTDIR=${D} install || die "install problem"

	dodoc Documentation/*
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO

	dodir /etc/{conf,init}.d /etc/dchub
	exeinto /etc/init.d
	newexe ${FILESDIR}/dchub.init.d dchub
	insinto /etc/conf.d
	newins ${FILESDIR}/dchub.conf.d dchub
}
