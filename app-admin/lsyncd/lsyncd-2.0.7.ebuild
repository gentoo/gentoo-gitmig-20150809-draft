# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/lsyncd/lsyncd-2.0.7.ebuild,v 1.1 2012/08/06 19:48:39 darkside Exp $

EAPI=4

inherit multilib

DESCRIPTION="Live Syncing (Mirror) Daemon"
HOMEPAGE="http://code.google.com/p/lsyncd/"
SRC_URI="http://lsyncd.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="dev-lang/lua"
RDEPEND="${DEPEND}
	net-misc/rsync"

src_configure() {
	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${P}
}
