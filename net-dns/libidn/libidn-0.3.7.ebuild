# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/libidn/libidn-0.3.7.ebuild,v 1.4 2004/06/17 05:32:24 weeve Exp $

DESCRIPTION="Internationalized Domain Names (IDN) implementation."
HOMEPAGE="http://www.gnu.org/software/libidn/"
SRC_URI="ftp://alpha.gnu.org/pub/gnu/libidn/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
# See http://www.gnu.org/software/libidn/manual/html_node/Supported-Platforms.html
KEYWORDS="x86 ~ppc ~amd64 ~sparc"
IUSE=""
DEPEND=""

src_compile()
{
	econf || die
	emake || die
}

src_install()
{
	einstall || die
}
