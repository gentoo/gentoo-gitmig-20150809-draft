# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nemesis/nemesis-1.4-r1.ebuild,v 1.1 2012/03/23 21:24:58 hwoarang Exp $

EAPI="4"

inherit eutils

DESCRIPTION="A commandline-based, portable human IP stack for UNIX/Linux"
HOMEPAGE="http://nemesis.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/_}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~sparc ~x86"
IUSE=""

RDEPEND="net-libs/libpcap"
DEPEND="${RDEPEND}
	=net-libs/libnet-1.0*"

DOCS="CREDITS ChangeLog README"

src_prepare() {
	epatch "${FILESDIR}"/${P}-fileio.patch
	epatch "${FILESDIR}"/${P}-libnet-1.0.patch
	epatch "${FILESDIR}"/${P}-prototcp.patch
}
