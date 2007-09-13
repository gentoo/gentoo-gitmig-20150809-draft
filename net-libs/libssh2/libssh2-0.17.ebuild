# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libssh2/libssh2-0.17.ebuild,v 1.2 2007/09/13 23:00:57 dragonheart Exp $

inherit eutils

DESCRIPTION="Library implementing the SSH2 protocol"
HOMEPAGE="http://www.libssh2.org/"
SRC_URI="mirror://sourceforge/libssh2/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libgcrypt"

DEPEND="!libgcrypt? ( dev-libs/openssl )
	libgcrypt? ( dev-libs/libgcrypt )
	sys-libs/zlib"
RDEPEND=${DEPEND}

src_compile() {
	econf $(use_enable libgcrypt) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README
}
