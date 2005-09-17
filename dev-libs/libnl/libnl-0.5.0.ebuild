# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libnl/libnl-0.5.0.ebuild,v 1.2 2005/09/17 21:08:40 vanquirius Exp $

inherit eutils

DESCRIPTION="A library for applications dealing with netlink socket"
HOMEPAGE="http://people.suug.ch/~tgr/libnl/"
SRC_URI="http://people.suug.ch/~tgr/libnl/files/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-include.diff"
}

src_install() {
	make DESTDIR="${D}" install || die
}
