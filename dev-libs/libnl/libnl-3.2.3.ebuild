# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libnl/libnl-3.2.3.ebuild,v 1.5 2011/11/27 22:41:37 jer Exp $

EAPI="4"

inherit eutils multilib

DESCRIPTION="A library for applications dealing with netlink socket"
HOMEPAGE="http://www.infradead.org/~tgr/libnl/"
SRC_URI="http://www.infradead.org/~tgr/libnl/files/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="3"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="static-libs utils"

AUTOTOOLS_IN_SOURCE_BUILD="1"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-1.1-vlan-header.patch
}

src_configure() {
	econf $(use_enable static-libs static) $(use_enable utils cli)
}

src_install() {
	default

	if ! use static-libs; then
		rm -f "${D}"/usr/lib*/lib*.la
	fi

	dodoc ChangeLog
}
