# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ucarp/ucarp-1.5.2.ebuild,v 1.1 2010/06/26 19:29:16 xarthisius Exp $

EAPI="2"

inherit base

DESCRIPTION="Portable userland implementation of Common Address Redundancy Protocol (CARP)."
HOMEPAGE="http://www.ucarp.org"
SRC_URI="ftp://ftp.ucarp.org/pub/ucarp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

RDEPEND="virtual/libpcap"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

DOCS=( "README" "NEWS" "AUTHORS" "ChangeLog"
	"examples/linux/vip-up.sh" "examples/linux/vip-down.sh" )

src_configure() {
	econf $(use_enable nls)
}
