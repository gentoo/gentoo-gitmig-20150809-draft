# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-libraries/nessus-libraries-2.3.1-r2.ebuild,v 1.1 2010/08/31 00:57:31 jer Exp $

EAPI="3"

inherit toolchain-funcs multilib eutils

DESCRIPTION="A remote security scanner for Linux (nessus-libraries)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/experimental/nessus-${PV}/src/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

# Hard dep on SSL since libnasl won't compile when this package is emerged -ssl.
DEPEND="dev-libs/openssl
	net-libs/libpcap"
RDEPEND=${DEPEND}

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-ldflags.patch
}

src_configure() {
	export CC=$(tc-getCC)
	econf --disable-nessuspcap --with-ssl="${EPREFIX}"/usr/$(get_libdir)
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "failed to install"
	dodoc README*
}
