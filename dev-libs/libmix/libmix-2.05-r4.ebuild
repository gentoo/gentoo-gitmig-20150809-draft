# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmix/libmix-2.05-r4.ebuild,v 1.1 2010/08/06 22:24:27 hwoarang Exp $

EAPI="2"
inherit autotools eutils

DESCRIPTION="Programs Crypto/Network/Multipurpose Library"
HOMEPAGE="http://mixter.void.ru/"
SRC_URI="http://mixter.void.ru/${P/.}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="no-net2"

DEPEND="!no-net2? ( virtual/libpcap net-libs/libnet )"

S=${WORKDIR}/${PN}-v${PV}

src_prepare() {
	epatch "${FILESDIR}"/${P}-fix-pattern.patch
	epatch "${FILESDIR}"/${P}-autotools.patch
	eautoreconf
}

src_configure() {
	econf $(use_with no-net2) || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc CHANGES
}
