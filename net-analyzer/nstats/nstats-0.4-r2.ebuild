# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nstats/nstats-0.4-r2.ebuild,v 1.1 2011/12/13 19:02:17 jer Exp $

EAPI=4

inherit eutils

DESCRIPTION="Displays statistics about ethernet traffic including protocol breakdown"
SRC_URI="http://trash.net/~reeler/nstats/files/${P}.tar.gz"
HOMEPAGE="http://trash.net/~reeler/nstats/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}"

DOCS=( BUGS doc/TODO doc/ChangeLog )

src_prepare(){
	epatch "${FILESDIR}"/${P}-makefile.patch

	if has_version '>=sys-libs/glibc-2.4' ; then
		epatch "${FILESDIR}"/${P}-glibc24.patch
	fi
}
