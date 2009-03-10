# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libpri/libpri-1.4.9.ebuild,v 1.1 2009/03/10 18:51:15 chainsaw Exp $

inherit eutils

IUSE=""

MY_P="${P/_/-}"

DESCRIPTION="Primary Rate ISDN (PRI) library"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="http://downloads.digium.com/pub/libpri/${MY_P}.tar.gz"

S="${WORKDIR}/${MY_P}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~ppc ~sparc"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${P}-respect-cflags.patch"
	epatch "${FILESDIR}/${P}-multilib.patch"
}

src_compile() {
	emake || die
}

src_install() {
	make INSTALL_PREFIX="${D}" LIBDIR="${D}/usr/$(get_libdir)" install || die

	dodoc ChangeLog README TODO
}
