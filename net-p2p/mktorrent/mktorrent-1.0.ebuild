# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mktorrent/mktorrent-1.0.ebuild,v 1.2 2010/04/20 21:16:21 sochotnicky Exp $

EAPI=1
inherit toolchain-funcs

DESCRIPTION="Simple command line utility to create BitTorrent metainfo files"
HOMEPAGE="http://mktorrent.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="threads +largefile +openssl debug"

RDEPEND="openssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}"

src_compile() {
	tc-export CC
	MAKEPARAM="USE_LONG_OPTIONS=1"
	use debug && MAKEPARAM="${MAKEPARAM} DEBUG=1"
	use largefile && MAKEPARAM="${MAKEPARAM} USE_LARGE_FILES=1"
	use openssl && MAKEPARAM="${MAKEPARAM} USE_OPENSSL=1"
	use threads && MAKEPARAM="${MAKEPARAM} USE_PTHREADS=1"

	emake ${MAKEPARAM} || die "emake failed."
}

src_install() {
	dobin ${PN}
	dodoc README
}
