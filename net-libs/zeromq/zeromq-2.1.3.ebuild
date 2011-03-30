# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/zeromq/zeromq-2.1.3.ebuild,v 1.1 2011/03/30 17:18:44 djc Exp $

# NOTES:
# 1- use flag 'pgm' (OpenPGM support) must be masked by profiles for ARM archs;

EAPI=3
WANT_AUTOCONF="2.5"
inherit autotools

PGM_VERSION=5.1.114

DESCRIPTION="ZeroMQ is a brokerless messaging kernel with extremely high performance."
HOMEPAGE="http://www.zeromq.org"
SRC_URI="http://download.zeromq.org/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pgm test static-libs"

RDEPEND=""
DEPEND="pgm? (
		dev-util/pkgconfig
		=net-libs/openpgm-${PGM_VERSION}
	)
	sys-apps/util-linux"

src_prepare() {
	einfo "Removing bundled OpenPGM library"
	rm -r "${S}"/foreign/openpgm || die
	epatch "${FILESDIR}/${P}"-configure.patch || die
	eautoreconf
}

src_configure() {
	myconf=""
	use pgm && localconf="--with-pgm=libpgm-${PGM_VERSION}"
	econf \
		$(use_enable static-libs static) \
		$(use_with pgm pgm "libpgm-${PGM_VERSION}")
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc NEWS README AUTHORS ChangeLog || die "dodoc failed"
	doman doc/*.[1-9] || die "doman failed"

	# remove useless .la files
	find "${D}" -name '*.la' -delete

	# remove useless .a (only for non static compilation)
	use static-libs || find "${D}" -name '*.a' -delete
}
