# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmix/libmix-2.05-r5.ebuild,v 1.2 2011/03/21 12:55:16 angelos Exp $

EAPI="2"

inherit autotools base multilib toolchain-funcs

DESCRIPTION="Programs Crypto/Network/Multipurpose Library"
HOMEPAGE="http://mixter.void.ru/"
SRC_URI="http://mixter.void.ru/${P/.}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="static-libs"
#IUSE="net2 static-libs"

#DEPEND="net2? ( virtual/libpcap net-libs/libnet:1.0 )"
#RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-v${PV}

PATCHES=(
	"${FILESDIR}"/${P}-fix-pattern.patch
	"${FILESDIR}"/${P}-gentoo.patch
	"${FILESDIR}"/${P}-libnet.patch
	"${FILESDIR}"/${P}-gentoo2.patch
)

DOCS=( CHANGES )

pkg_setup() {
	tc-export CC CXX
}

src_prepare(){
	base_src_prepare
	eautoreconf
}

# net-libs/libnet doesn't provide shared libs, cannot be used currently

src_configure() {
	econf \
		--libdir=/usr/$(get_libdir) \
		$(use_enable static-libs static) \
		--without-net2
#		$(use_with net2)
}
