# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ncdc/ncdc-1.9.ebuild,v 1.1 2012/03/17 19:37:56 xmw Exp $

EAPI=4

DESCRIPTION="ncurses directconnect client"
HOMEPAGE="http://dev.yorhel.nl/ncdc"
SRC_URI="http://dev.yorhel.nl/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="app-arch/bzip2
	dev-db/sqlite:3
	dev-lang/perl
	dev-libs/glib:2
	dev-libs/libxml2:2
	net-libs/glib-networking
	sys-libs/gdbm
	sys-libs/ncurses:5"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
