# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libnl/libnl-0.5.0.ebuild,v 1.3 2005/09/18 15:39:24 dertobi123 Exp $

inherit eutils

DESCRIPTION="A library for applications dealing with netlink socket"
HOMEPAGE="http://people.suug.ch/~tgr/libnl/"
SRC_URI="http://people.suug.ch/~tgr/libnl/files/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-include.diff"
}

src_install() {
	make DESTDIR="${D}" install || die
}
