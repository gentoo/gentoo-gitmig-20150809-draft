# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmix/libmix-2.05.ebuild,v 1.14 2011/02/06 12:38:27 leio Exp $

inherit multilib

DESCRIPTION="Programs Crypto/Network/Multipurpose Library"
HOMEPAGE="http://mixter.void.ru/"
SRC_URI="http://mixter.void.ru/${P/.}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="no-net2"

DEPEND="!no-net2? ( virtual/libpcap net-libs/libnet )"

S=${WORKDIR}/${PN}-v${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i "s:-O3 -funroll-loops:${CFLAGS} -fPIC:" configure
}

src_compile() {
	econf $(use_with no-net2) || die
	emake || die
}

src_install() {
	make \
		INSTALL_INCLUDES_IN="${D}"/usr/include \
		INSTALL_LIBRARY_IN="${D}"/usr/$(get_libdir) \
		INSTALL_MANPAGE_IN="${D}"/usr/share/man \
		install || die
	dodoc CHANGES
}
