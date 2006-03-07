# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libnl/libnl-0.5.0.ebuild,v 1.8 2006/03/07 11:38:43 jer Exp $

inherit eutils multilib

DESCRIPTION="A library for applications dealing with netlink socket"
HOMEPAGE="http://people.suug.ch/~tgr/libnl/"
SRC_URI="http://people.suug.ch/~tgr/libnl/files/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 hppa ~ppc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${P}-include.diff"
	epatch "${FILESDIR}/${P}-libdir.patch"
}

src_install() {
	make DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" install || die
}
