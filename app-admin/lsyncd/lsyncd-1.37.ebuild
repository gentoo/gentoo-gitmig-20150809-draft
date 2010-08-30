# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/lsyncd/lsyncd-1.37.ebuild,v 1.1 2010/08/30 22:51:48 xmw Exp $

EAPI=2

inherit base

DESCRIPTION="Live Syncing (Mirror) Daemon"
HOMEPAGE="http://code.google.com/p/lsyncd/"
SRC_URI="http://lsyncd.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="xml"

DEPEND="xml? ( dev-libs/libxml2 )"
RDEPEND="${DEPEND}
	net-misc/rsync"

src_configure() {
	local my_config="--enable-xml-config=no"
	if use xml ; then
		my_config="--enable-xml-config=yes"
	fi
	econf ${my_config}
}
